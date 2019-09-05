# Mac-tour - API server
## Environments
```
gcloud SDK
Anaconda/ miniconda
```
## 실행
### 개발 및 테스트하기
#### Configuration
```
config.py
- serviceAccount
(app engine 배포시 불필요)
```
```markdown
conda create -n mac-tour python=3.7
conda activate mac-tour
pip install -r requirements.txt
pip install -t lib/ flask-restplus
gunicorn -b :$PORT main:app
```

### 배포하기
#### Configuration

```
config.py
- level -> INFO
- debug -> False
```
```markdown
gcloud SDK 설치 및 관련 설정(계정, 프로젝트) 완료
pip install -t lib/ flask-restplus
gcloud components install app-engine-python
gcloud app deploy
```
