import { html, render } from 'lit-html'
import i18next from 'i18next'
import { css } from 'emotion'

export class TabBar extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)
	}

	render() {
		return html`
        <div class="${style} toolbar tabbar tabbar-labels toolbar-bottom">
            <div class="toolbar-inner">
                <a href="#tab-1" class="tab-link tab-link-active">
                    <i class="icon f7-icons if-not-md">info_round_fill</i>
                    <i class="icon f7-icons md-only">info_round</i>
                    <span class="tabbar-label">${i18next.t(`DETAIL_INFO`)}</span>
                </a>
                <a href="#tab-2" class="tab-link" @click="${this.clickTab2}">
                    <i class="icon f7-icons if-not-md">navigation_round_fill</i>
                    <i class="icon f7-icons md-only">navigation_round</i>
                    <span class="tabbar-label">${i18next.t(`TOUR_GUIDE`)}</span>
                </a>                
                <a href="#tab-3" class="tab-link" @click="${this.clickTab3}">
                    <i class="icon f7-icons if-not-md">world_fill</i>
                    <i class="icon f7-icons md-only">world</i>
                    <span class="tabbar-label">${i18next.t(`APPLY`)}</span>
                </a>
            </div>
        </div>		
        `
	}
    
	get clickTab2() {
		return {
			handleEvent() {
				document.querySelector(`page-detail`).initTmap()
			},
			capture: true,
			once: true,
		}
	}
    
	get clickTab3() {
		return {
			handleEvent() {
				cordova.InAppBrowser.open(document.querySelector(`page-detail`).applyUrl, `_system`)
			},
			capture: true,
		}
	} 
}

const style = css`
& {
    height: 65px;
}
`

customElements.define(`tab-bar`, TabBar)
