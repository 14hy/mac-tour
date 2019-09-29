import { html, render } from 'lit-html'
// import i18next from 'i18next'

import '../components/swiper-slider.js'
import '../components/swiper-slider-nearby'

export class PageDetail extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)		
        
		this.initTmap()
	}

	render() {
		return html`
		${style}
		<div id="pageDetail" class="page-content">
            <header>
                <a class="btn-back" href="/"><i class="f7-icons">chevron_left</i></a>
                <div class="brew-name">브루어리 이름</div>
            </header>
            <main>      
                <swiper-slider></swiper-slider>

                <div class="btn-list">
                    <button class="col button button-raised">홈페이지</button>
                    <button class="col button button-raised">길찾기</button>
                    <button class="col button button-raised">공유</button>
                </div>
                
                <div id="tMap"></div> 
            </main>
		</div>
        `
	}
    
	initTmap(){
		const map = new Tmap.Map({
			div:`tMap`,
		})
		map.setCenter(new Tmap.LonLat(`126.986072`, `37.570028`).transform(`EPSG:4326`, `EPSG:3857`), 15)
	} 
}

const style = html`
<style>
page-detail {
    display: flex;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

page-detail #pageDetail {
    border: 1px solid #595959;
    width: 100%;
    height: 100%;
    margin: 0 auto;
    padding: 0;
    border-radius: 2px;    

    display: grid;
    grid-template-rows: 50px auto;
}

page-detail header {
    display: grid;
    grid-template-columns: 50px auto;
    align-items: center;
    position: relative;    
}

page-detail header:after {
    content: '';
    position: absolute;
    right: 0;
    width: 100%;
    top: 100%;
    bottom: auto;
    height: 10px;
    pointer-events: none;
    background: linear-gradient(to bottom,rgba(0,0,0,.3) 0,rgba(0,0,0,.1) 40%,rgba(0,0,0,.05) 50%,rgba(0,0,0,0) 80%,rgba(0,0,0,0) 100%);
}

page-detail .btn-back {
    display: flex;
    align-items: center;
    justify-content: center;

}

page-detail main {
    display: grid;
    grid-auto-rows: 150px 40px auto;
    grid-row-gap: 5px;
    overflow: hidden;
}

page-detail #tMap {
    height: 100%;
    margin: 3px !important;
    position: relative;
    background-color: #EEEEEE;
}

page-detail .btn-list {
    margin: 5px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-column-gap: 10px;
}

page-detail .btn-list span {
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

page-detail .logo, page-detail .title, page-detail .select-local, page-detail .my-local, page-detail footer span {
    background-color: #EEEEEE;
    margin: 5px;
    border-radius: 3px;
    color: #999999;
    display: flex;
    justify-content: center;
    align-items: center;
}

page-detail button, page-detail .brew-name {  
    margin: 3px;
    border: 0;
    color: black;
    display: flex;
    justify-content: center;
    align-items: center;
}

page-detail .brew-name {    
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0;
    padding-left: 20px;
    padding-right: 50px;
    font-weight: bold;
}
</style>
`

customElements.define(`page-detail`, PageDetail)
