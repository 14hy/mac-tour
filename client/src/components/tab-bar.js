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
                    <i class="icon f7-icons if-not-md">navigation_round_fill</i>
                    <i class="icon f7-icons md-only">navigation_round</i>
                    <span class="tabbar-label">투어 정보</span>
                </a>
                <a href="#tab-2" class="tab-link">
                    <i class="icon f7-icons if-not-md">info_round_fill</i>
                    <i class="icon f7-icons md-only">info_round</i>
                    <span class="tabbar-label">정보 확인</span>
                </a>
                <a href="#tab-3" class="tab-link">
                    <i class="icon f7-icons if-not-md">email_fill</i>
                    <i class="icon f7-icons md-only">email</i>
                    <span class="tabbar-label">${i18next.t(`APPLY`)}</span>
                </a>
            </div>
        </div>		
        `
	}
}

const style = css`
& {
    
}
`

customElements.define(`tab-bar`, TabBar)
