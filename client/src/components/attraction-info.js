import { html, render } from 'lit-html'
// import i18next from 'i18next'
import { css } from 'emotion'

export class AttractionInfo extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)    
	}

	render(obj) {
		if (!obj) {
			return html``
		}
        
		return html`
        <div class="list media-list ${style}">
            <ul>
                ${this.templateLi(`sort_round`,`설명`, obj.desc.split(`.`)[0])}
                ${this.templateLi(`time`,`투어 가능 시간`, obj.availableDay)}
                ${this.templateLi(`money_dollar_round`,`예상 가격대`, `${obj.price}원`)}
            </ul>
        </div>	
        `
	}
    
	reRender(obj) {
		render(this.render(obj), this)
	}
    
	templateLi(icon, title, content) {
		return html`
        <li>
            <div class="item-content">
                <div class="item-media">
                    <i class="f7-icons icon-money">${icon}</i>
                </div>

                <div class="item-inner">
                    <div class="item-title-row">
                        <div class="item-title">${title}</div>
                    </div>
                    <div class="item-subtitle">${content}</div>
                </div>
            </div>
        </li>
        `
	}
}

const style = css`
& {
   .icon-money {
        display: inline-block;
        margin: 10px auto;
   } 

    li:nth-child(1) .item-subtitle {
        word-break: keep-all;
        white-space: pre-line;
   }
}
`

customElements.define(`attraction-info`, AttractionInfo)
