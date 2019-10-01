import { html, render } from 'lit-html'
import i18next from 'i18next'
import { css, injectGlobal } from 'emotion'

export class regionSelector extends HTMLElement {
	constructor() {
		super()
        
		this._handlers = {}
	}

	connectedCallback() {
		render(this.render(), this)		
        
		const handlers = this._handlers

		handlers.onClick = this._onClick.bind(this)
		document.addEventListener(`click`, handlers.onClick)
	}
    
	disconnectedCallback() {
		document.removeEventListener(`click`, this._handlers.onClick)
	}

	render() {
		return html`
        <div class="list ${styles}">
            <ul>
                <li>
                    <a class="item-link smart-select smart-select-init" data-open-in="popover">
                        <select name="region">
                            <option value="all" selected>${i18next.t(`REGION_ALL`)}</option>
                            ${[1,2,3,4,5,6,7,8].map(li => html`<option value="${li}">${i18next.t(`REGION_${li}`)}</option>`)}
                        </select>

                        <div class="item-content">
                            <div class="item-inner">
                                <div class="item-title"></div>
                                <div class="item-after">${i18next.t(`REGION_ALL`)}</div>
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
        `
	}
    
	_onClick(event) {
		this.clickRegionSelector(event)
	}
    
	clickRegionSelector(event) {        
		if (event.target.closest(`[data-select-name="region"] li`)) {
			let region = event.target.textContent.trim()
			if (!region) {
				return
			}
			region = region === `모든 지역` ? [`경기`, `서울`, `충청`, `강원`, `전라`, `경상`, `부산`, `제주`] : [region]
			document.querySelector(`page-main`).contentLoading(region)
		}			
	}
}

const styles = css`
& {
    & .list {
        margin: 0;
    }

    & .smart-select div.item-title {
        max-width: none;
        text-align: center;
        font-size: 12px;
    }

    & .smart-select div.item-after {
        width: 100px;
        max-width: none;
        text-align: center;
        font-weight: bold;
    }

    & .list ul:after, & .list ul:before {
        background-color: transparent;
    }

    & .item-inner {
        padding-left: 15px;
    }

    & .item-inner:before {
        content: 'chevron_down' !important;
    }    
}
`
injectGlobal`
[data-select-name="region"] .popover-inner {    
    max-height: none;
}    

[data-select-name="region"].popover-on-right {
    width: 180px;
}
` 

customElements.define(`region-selector`, regionSelector)
