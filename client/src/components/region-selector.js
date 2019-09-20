import { html, render } from 'lit-html'
import i18next from 'i18next'

export class regionSelector extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)		
	}

	render() {
		return html`
        ${style}
        <div class="list">
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
}

const style = html`
<style>
region-selector .list {
    margin: 0;
}

region-selector .smart-select div.item-after {
    width: 100px;
    max-width: none;
    text-align: center;
    font-weight: bold;
}

region-selector .list ul:after, region-selector .list ul:before {
    background-color: transparent;
}

region-selector .item-inner {
    padding-left: 15px;
}

region-selector .item-inner:before {
    content: 'chevron_down' !important;
}

[data-select-name="region"] .popover-inner {    
    max-height: none;
}

[data-select-name="region"].popover-on-right {
    width: 180px;
}
</style>
`

customElements.define(`region-selector`, regionSelector)
