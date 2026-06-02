function _qtheme_git_info \
--description "Produce 'BRANCH STAGED CHANGED UNTRACKED BEHIND AHEAD DIVERGED STASHED CONFLICTS CLEAN'"
    set branch (
        command git branch --show-current 2>/dev/null ||
        command git describe --tags --exact-match HEAD 2>/dev/null ||
        command git rev-parse --short HEAD 2>/dev/null |
            string replace --regex -- '(.+)' '@\$1'
    )
    test -z $branch
    and return 0

    # 변수 초기화 (순서: STAGED, CHANGED, UNTRACKED, BEHIND, AHEAD, DIVERGED, STASHED, CONFLICTS, CLEAN)
    set -l count_staged 0
    set -l count_changed 0
    set -l count_untracked 0
    set -l count_behind 0
    set -l count_ahead 0
    set -l count_diverged 0
    set -l count_stashed 0
    set -l count_conflicts 0
    set -l count_clean 1

    # git status 실행 결과를 배열로 받아오기
    set -l lines (command git status --porcelain -b 2> /dev/null)
    if test $status -eq 128
        return 1 # 심각한 오류 발생 시 중단
    end

    # 브랜치 트래킹 정보 처리 (첫 번째 줄)
    if set -q lines[1]; and string match -q -r '^## [^ ]+ \[(.*)\]' $lines[1]
        set -l match_str (string match -r '^## [^ ]+ \[(.*)\]' $lines[1])[2]
        set -l items (string split ',' $match_str)
        
        for item in $items
            set -l parts (string match -r '(behind|ahead|diverged) ([0-9]+)?' $item)
            if set -q parts[2]
                set -l num 0
                if set -q parts[3]; and test -n "$parts[3]"
                    set num $parts[3]
                end
                
                switch $parts[2]
                    case behind
                        set count_behind $num
                    case ahead
                        set count_ahead $num
                    case diverged
                        set count_diverged $num
                end
            end
        end
    end

    # 상태 정보 처리
    for line in $lines
        if string match -q -r '^##|^!!' $line
            continue
        else if string match -q -r '^U[ADU]|^[AD]U|^AA|^DD' $line
            set count_conflicts (math $count_conflicts + 1)
        else if string match -q -r '^\?\?' $line
            set count_untracked (math $count_untracked + 1)
        else if string match -q -r '^[MTARC][MTD]' $line
            set count_staged (math $count_staged + 1)
            set count_changed (math $count_changed + 1)
        else if string match -q -r '^[MTADRC] ' $line
            set count_staged (math $count_staged + 1)
        else if string match -q -r '^ [MTADRC]' $line
            set count_changed (math $count_changed + 1)
        end
    end

    # Stash 확인
    if command git rev-parse --verify refs/stash >/dev/null 2>&1
        set -l stash_count (command git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
        if test -n "$stash_count"
            set count_stashed $stash_count
        end
    end

    # Clean 플래그 업데이트
    if test $count_staged -gt 0 -o $count_changed -gt 0 -o $count_untracked -gt 0 -o $count_behind -gt 0 -o $count_ahead -gt 0 -o $count_diverged -gt 0 -o $count_stashed -gt 0 -o $count_conflicts -gt 0
        set count_clean 0
    end

    # 최종 출력 (string split 으로 처리하기 편하게 띄어쓰기로 구분)
    echo "$branch $count_staged $count_changed $count_untracked $count_behind $count_ahead $count_diverged $count_stashed $count_conflicts $count_clean"
end
