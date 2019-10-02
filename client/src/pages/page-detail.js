import { html, render } from 'lit-html'
import i18next from 'i18next'
import { css } from 'emotion'

import { loadXhr } from '../libs/actions.js'

import '../components/swiper-slider.js'
import '../components/tab-bar.js'

export class PageDetail extends HTMLElement {
	constructor() {
		super()
        
		this.brewerName = `브루어리 이름`
		this.homepageUrl = ``
		this.location = {
			lon: `126.986072`,
			lat: `37.570028`,
		}
	}

	connectedCallback() {
		render(this.render(), this)
        
		this.contentLoading()
	}
    
	async contentLoading() {
		let res = await loadXhr({
			url: `https://mac-tour-dot-mac-tour-251517.appspot.com/detail-page/?BreweryName=${window.mainView.router.currentRoute.params.brewerName}`,
			method: `GET`,
		})

		res = JSON.parse(res)
        
		this.brewerName = res.brewery.name
		this.brewerImg = res.brewery.url_img
		this.homepageUrl = res.brewery.home_page
		this.location = {
			lon: res.brewery.location[0],
			lat: res.brewery.location[1],
		}		
        
		render(this.render(), this)
		this.querySelector(`swiper-slider`).reRender()	
        
		this.initTmap()		
	}

	render() {
		return html`
        <div id="pageDetail" class="${styles} tabs">
            <div class="page-content tab tab-active" id="tab-1">
                <header>
                    <a class="btn-back" href="/"><i class="f7-icons">chevron_left</i></a>
                    <div class="brew-name">${this.brewerName}</div>
                </header>
                <main>      
                    <swiper-slider .brewerImg="${this.brewerImg}"></swiper-slider>

                    <div class="btn-list">
                        <button class="col button button-raised" @click="${this.clickHomepage}">${i18next.t(`HOMEPAGE`)}</button>
                        <button class="col button button-raised" @click="${this.clickSearchRoad}">${i18next.t(`FIND_ROAD`)}</button>
                        <button class="col button button-raised">${i18next.t(`SHARE`)}</button>
                    </div>
                    
                    <div id="divTMap"></div>
                </main>
            </div>
            <div class="page-content tab" id="tab-2">
                <div class="block">
                    <p><b>Tab 2 content</b></p>
                </div>
            </div>
            <tab-bar></tab-bar>
		</div>
        `
	}
    
	initTmap(){
		this.map = new Tmap.Map({
			div:`divTMap`,
		})
		this.map.removeZoomControl()
		// this.map.ctrl_nav.disableZoomWheel()
		// this.map.ctrl_nav.dragPan.deactivate()  
		
		this.map.setCenter(new Tmap.LonLat(this.location.lon, this.location.lat).transform(`EPSG:4326`, `EPSG:3857`), 16)  
        
		this.addMarkerLayer()
	}
    
	addMarkerLayer() {
		const markerLayer = new Tmap.Layer.Markers(`marker`)
		this.map.addLayer(markerLayer)
        
		const lonlat = new Tmap.LonLat(this.location.lon, this.location.lat).transform(`EPSG:4326`, `EPSG:3857`)
		const size = new Tmap.Size(24, 38)
		const offset = new Tmap.Pixel(-(size.w / 2), -size.h)
		const icon = new Tmap.Icon(`http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png`,size, offset)
		this.marker = new Tmap.Marker(lonlat, icon)
        
		markerLayer.addMarker(this.marker)
	}
    
	searchPOI(map) {
		const tdata = new Tmap.TData()
		const center = map.getCenter()
        
		tdata.events.register(`onComplete`, tdata, this.onCompleteTData)		
		tdata.getPOIDataFromSearch(encodeURIComponent(this.brewerName), {
			centerLon:center.lon, 
			centerLat:center.lat, 
			reqCoordType:`EPSG3857`, 
			resCoordType:`EPSG3857`,
		})
	}
    
	onCompleteTData() {
		// const poi = this.responseXML.querySelectorAll(`searchPoiInfo pois poi`)
		// console.log(poi)
		// if (!poi) {
		// 	return
		// }	
		// console.log(`end`)	
	}    
    
	get clickHomepage() {
		const root = this
		return {
			handleEvent() {
				cordova.InAppBrowser.open(root.homepageUrl, `_self`)
			},
			capture: false,
		}
	} 
    
	get clickSearchRoad() {
		const root = this
		return {
			handleEvent() {
				cordova.InAppBrowser.open(`https://map.kakao.com/link/to/${root.brewerName},${root.location.lat},${root.location.lon}`, `_system`)
			},
			capture: false,
		}
	}
}

customElements.define(`page-detail`, PageDetail)

const styles = css`
& {    
    & .page-content {
        border: 1px solid #595959;
        width: 100%;
        height: calc(100% - 65px);
        margin: 0 auto;
        padding: 0;
        border-radius: 2px;    
    
        display: grid;
        grid-template-rows: 50px auto;
    
        & header {
            display: grid;
            grid-template-columns: 50px auto;
            align-items: center;
            position: relative;
    
            &:after {
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
    
            & .btn-back {
                display: flex;
                align-items: center;
                justify-content: center;        
            }        
    
            & .brew-name {    
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 0;
                padding-left: 20px;
                padding-right: 50px;
                font-weight: bold;
            }
        }
    
        & main {
            display: grid;
            grid-auto-rows: 150px 40px auto;
            grid-row-gap: 5px;
            overflow: hidden;
    
            & #divTMap {
                height: 100%;
                margin: 3px !important;
                position: relative;
                background-color: #EEEEEE;
            }
    
            & .btn-list {
                margin: 5px;
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                grid-column-gap: 10px;
    
                & span {
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
            }
    
            & .logo, & .title, & .select-local, & .my-local, & footer span {
                background-color: #EEEEEE;
                margin: 5px;
                border-radius: 3px;
                color: #999999;
                display: flex;
                justify-content: center;
                align-items: center;
            }        
        }
    }

    & .tab {
        display: none;
    }

    & .tab-active {
        display: grid;
    }
}
`
