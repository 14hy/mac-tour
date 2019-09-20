import { html, render } from 'lit-html'
import i18next from 'i18next'

export class SwiperSliderNearby extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)		
	}

	render() {
		return html`
		${style}
		<div data-pagination='{"el": ".swiper-pagination"}' data-space-between="10" data-slides-per-view="2" class="swiper-container swiper-init demo-swiper">
            <div class="swiper-pagination"></div>
            <div class="swiper-wrapper">
                <div class="swiper-slide">${i18next.t(`PICTURE_1`)}</div>
                <div class="swiper-slide">음식점</div>
                <div class="swiper-slide">관광지</div>
                <div class="swiper-slide">느낌적인 느낌</div>
                <div class="swiper-slide">Slide 5</div>
                <div class="swiper-slide">Slide 6</div>
            </div>
        </div>
        `
	}
}

const style = html`
<style>
swiper-slider-nearby {
    height: 120px;
    margin: 1px;
    position: relative;

    margin: 5px;
    border-radius: 3px;
    display: flex;
    justify-content: center;
    align-items: center;

    border-radius: 15px;
    overflow: hidden;
}

swiper-slider-nearby .swiper-container {
    width: 100%;
    height: 100%;
}

swiper-slider-nearby .swiper-slide {
    display: flex;
    justify-content: center;
    align-items: center;
}

swiper-slider-nearby .swiper-slide:nth-child(1) {
    background-image: url(https://storage.googleapis.com/mac-tour-251517.appspot.com/breweries/brewery4.jpeg);
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    
}
</style>
`

customElements.define(`swiper-slider-nearby`, SwiperSliderNearby)
