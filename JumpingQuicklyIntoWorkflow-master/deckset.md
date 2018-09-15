footer: © elvin, 2018
slidenumbers: true
autoscale: true

# iTerm2, AppleScript, and Jumping Quickly into Your Workflow
### 2018. 05. 14 <br> elvin.han

---

## Goal

- 개발 준비 과정 자동화
- One Command로 개발 준비를 끝마치자!

---

# 서버 프로젝트<br>개발 준비 과정

---

## Backend
- project home 경로로 이동
- pipenv shell
- git pull
- db migrate
- pycharm 실행

---

## Front

- project home / front / admin 경로로 이동
- npm i
- npm start

---

## CLI / Flask Shell

- project home 경로로 이동
- pipenv shell

---

# Tools

---

## [iTerm2](https://www.iterm2.com/)
- MacOS용 터미널 어플리케이션
- Profile
- Tab (cmd+t, cmd+o)
- Split Horizontally (cmd+shift+d, cmd+shift+opt+h)
- Split Vertically (cmd+d, cmd+shift+opt+v)
- Maximize active panel (cmd+shift+enter)

---

## AppleScript  
  - Apple에서 만든 스크립트 언어
  - MacOS에 통합되어있음

---

## [iTerm2 AppleScript Integration](https://www.iterm2.com/documentation-scripting.html)
  - New Tab
  - Split Vertically  

---

# Demo

```
$> osascript demo.scpt
```


---

## Reference

- [iTerm2, AppleScript, and Jumping Quickly into Your Workflow](https://medium.com/@sunskyearthwind/iterm-applescript-and-jumping-quickly-into-your-workflow-1849beabb5f7)
- [Demo Github](https://github.com/elvin-han/JumpingQuicklyIntoWorkflow)
