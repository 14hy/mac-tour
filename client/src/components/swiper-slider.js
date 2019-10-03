import { html, render } from 'lit-html'
// import i18next from 'i18next'
import { css, injectGlobal } from 'emotion'

export class SwiperSlider extends HTMLElement {
	constructor() {
		super()
        
		this.imgList = []
	}

	connectedCallback() {
		render(this.render(), this)		
	}
    
	reRender() {
		render(this.render(), this)
	}

	render() {		
		return html`
        <div class="swiper-wrap ${styles}">
            <div data-pagination='{"el": ".swiper-pagination"}' 
                data-space-between="10" 
                data-slides-per-view="2"
                data-centered-slides="true"
                class="swiper-container swiper-init demo-swiper demo-swiper-auto">
                    <div class="swiper-pagination"></div>
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="${this.brewerImg}" alt=""/></div>
                        ${this.imgList ? this.imgList.map(img => this.templateImgSlide(img)) : html`<div class="swiper-slide"><img src="${this.brewerImg}" alt=""/></div>`}
                    </div>
            </div>
        </div>		
        `
	}
    
	templateImgSlide(img) {        
		return html`
        <div class="swiper-slide"><img src="${img.firstimage}" alt=""/></div>
        `
	}
}

injectGlobal`
swiper-slider {
    overflow: hidden;
}
`

const styles = css`
& {
    height: 150px;
    margin: 1px;
    position: relative;

    margin: 5px;
    border-radius: 3px;
    display: flex;
    justify-content: center;
    align-items: center;
    
    overflow: hidden;

    .swiper-container {
        width: 100%;
        height: 100%;
    }

    .swiper-slide {
        display: flex;
        justify-content: center;
        align-items: center;

        img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    }
}
`

customElements.define(`swiper-slider`, SwiperSlider)
