import { html, render } from 'lit-html'
// import i18next from 'i18next'

export class PageDetail extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)		
	}

	render() {
		return html`
		${style}
		<div id="pageDetail" class="page-content">
            <header>
                <a href="/"><</a>
                <div class="search"></div>
            </header>
            <main>      
                <div class="content">
                    <span>양조장 사진</span>
                    <span class="local-name">양조장명</span>
                </div>
                <div class="btn">
                    <span>홈페이지</span>
                    <span>지도보기</span>
                    <span>길찾기</span>
                </div>
                <div class="content-2">양조장 소개</div>
                <div class="content-2">관광지 1</div>
                <div class="content-2">관광지 2</div>
                <div class="content-2"></div>
                <div class="content-2"></div>
            </main>
		</div>
        `
	}
}

const style = html`
<style>
page-detail {
    display: flex;
    position: absolute;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    margin: 0;
    padding: 0;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

page-detail #pageDetail {
    border: 1px solid #595959;
    width: 100vw;
    height: 100vh;
    margin: 0 auto;
    padding: 0;
    border-radius: 2px;    

    display: grid;
    grid-template-rows: 50px auto;
}

page-detail header {
    display: grid;
    grid-template-columns: 30px auto;
    border-bottom: 1px solid #595959;
}

page-detail main {
    overflow: scroll;
}

page-detail .content {
    height: 150px;
    margin: 1px !important;
    position: relative;
}

page-detail .content-2 {
    height: 150px;
    margin: 3px !important;
    position: relative;
    background-color: #EEEEEE;
}

page-detail .btn {
    display: grid;
    grid-template-columns: auto auto auto; 
}

page-detail .btn span {
    background-color: #EEEEEE;
    height: 50px;
    margin: 5px;
    border-radius: 3px;
    color: #999999;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
}

page-detail .logo, page-detail .title, page-detail .select-local, page-detail .my-local, page-detail footer span, page-detail .content, page-detail .search, page-detail .content-2 {
    background-color: #EEEEEE;
    margin: 5px;
    border-radius: 3px;
    color: #999999;
    display: flex;
    justify-content: center;
    align-items: center;
}

page-detail .search {
    padding-left: 20px;
}

page-detail button, page-detail .search {  
    background-color: #EEEEEE;
    margin: 3px;
    border: 0;
    color: black;
    display: flex;
    justify-content: center;
    align-items: center;
}

page-detail .search {
    justify-content: end;
}
</style>
`

customElements.define(`page-detail`, PageDetail)
