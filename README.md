# mkvsrt-merger
폴더에 있는 mkv에 smi,srt,ass 자막을 병합합니다.

파일 관리의 편의성, 기기별 호환성 개선을 위해 제작되었습니다.

video.mkv(mp4) + video.srt = video_subs.mkv

이슈 PR 아주 환영합니다!


사용법
===

사용법: `conv <파일 또는 폴더> [파일] [출력] [/R]`

`conv <비디오> <자막> [<출력할 파일명>.<확장자>]`

`conv <폴더> [/R]`

`conv <비디오>`
비디오만 선택한다면 자막은 같은 이름을 가지고
`.srt` `.ko.srt` `.kor.srt` `.ko.kor.srt` `.smi.srt` `.smi.ko.srt` `.smi.kor.srt` `.smi.ko.kor.srt`
`.ass` `.ko.ass` `.kor.ass` `.ko.kor.ass`
`.smi.ass` `.smi.ko.ass` `.smi.kor.ass` `.smi.ko.kor.ass` 확장자를 가지고 있어야 합니다.


smi?
====
SAMI(`.smi`) 자막은 자동으로 SubRip(`.srt`) 자막으로 변환되어 같은 폴더에 저장됩니다.(설정에서 제어 가능)
