import { html, render } from 'lit-html'
import i18next from 'i18next'

import '../components/swiper-slider.js'
import '../components/swiper-slider-nearby'

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
                <a class="btn-back" href="/"><i class="f7-icons">chevron_left</i></a>
                <div class="search">브루어리 이름</div>
            </header>
            <main>      
                <swiper-slider></swiper-slider>

                <div class="btn">
                    <button class="col button button-raised">홈페이지</button>
                    <button class="col button button-raised">길찾기</button>
                    <button class="col button button-raised">공유</button>
                </div>
                <div class="content-2">양조장 설명</div>
                
                <div class="_t_map_api">지도~~</div>

                <div class="block">
                    <p class="segmented segmented-raised">
                        <button class="col button button-raised">관광지</button>
                        <button class="col button button-raised">음식점</button>
                        <button class="col button button-raised button-active">숙박</button>
                        <button class="col button button-raised">그런</button>
                        <button class="col button button-raised">느낌</button>
                        <button class="col button button-raised button-active">으로</button>
                    </p>
                </div>

                <swiper-slider-nearby></swiper-slider-nearby>
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
}

page-detail .btn-back {
    display: flex;
    align-items: center;
}

page-detail main {
    overflow: scroll;
}

page-detail .content-2 {
    height: 150px;
    margin: 3px !important;
    position: relative;
    background-color: #EEEEEE;
}

page-detail ._t_map_api {
    height: 400px;
    margin: 3px !important;
    position: relative;
    background-color: #EEEEEE;
}

page-detail .btn {
    margin: 5px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-column-gap: 10px;
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

page-detail .logo, page-detail .title, page-detail .select-local, page-detail .my-local, page-detail footer span, page-detail ._t_map_api, page-detail .content-2 {
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
    margin: 3px;
    border: 0;
    color: black;
    display: flex;
    justify-content: center;
    align-items: center;
}

page-detail .search {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0;
    padding-right: 30px;
    font-weight: bold;
}

</style>
`

customElements.define(`page-detail`, PageDetail)
