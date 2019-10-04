import { html, render } from 'lit-html'
import i18next from 'i18next'
import { css, injectGlobal } from 'emotion'

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
		this.vectorLayer = []
		this.markerLayers = []
	}

	connectedCallback() {
		render(this.render(), this)
        
		this.contentLoading()
	}	

	render() {
		return html`
        <div id="pageDetail" class="${styles} tabs">
            <div class="page-content tab tab-active" id="tab-1">
                <header>
                    <a class="btn-back" href="/"><i class="f7-icons">chevron_left</i></a>
                    <div class="brew-name">${i18next.t(`BREWERY_TITLE_SUB`)}</div>
                </header>
                <main>      
                    <swiper-slider
						.breweryName="${this.brewerName}"
                        .brewerImg="${this.brewerImg}"
                        .imgList="${this.aroundAttraction}">
                    </swiper-slider>

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
        
		this.aroundAttraction = res.content
		this.logo = res.brewery.url_logo
        
		render(this.render(), this)
		this.querySelector(`swiper-slider`).reRender()        
		window.app.swiper.get(`.swiper-container`).eventsListeners.activeIndexChange.push(this.startBreweryMarker)

		this.initTmap()
	}
    
	initTmap(){
		this.map = new Tmap.Map({
			div:`divTMap`,
		})
		this.map.removeZoomControl()
		this.map.ctrl_nav.disableZoomWheel()
		this.map.ctrl_nav.dragPan.deactivate() 
		
		this.map.setCenter(new Tmap.LonLat(this.location.lon, this.location.lat).transform(`EPSG:4326`, `EPSG:3857`), 16)
        
		this.addMarkerLayer()
	}
    
	startBreweryMarker() {
		const root = document.querySelector(`page-detail`)
        
		root.map.layers.forEach(each => {		
			if (each.name === `marker`) {
				each.clearMarkers()
			}
	
			if (each.name === `vectorLayerID`) {
				each.removeAllFeatures()
			}
		})
        
		if (this.activeIndex === 0 ) {
			root.addMarkerLayer()			
			return
		}	

		const tData = new Tmap.TData()
		const startLonLat = new Tmap.LonLat(root.location.lon, root.location.lat)
		const endLonLat = new Tmap.LonLat(root.aroundAttraction[this.activeIndex - 1][`mapx`], root.aroundAttraction[this.activeIndex - 1][`mapy`])
		const option = {
			reqCoordType:`WGS84GEO`, 
			resCoordType:`EPSG3857`, 
		}								
        
		tData.getRoutePlan(startLonLat, endLonLat, option)
		tData.events.register(`onComplete`, tData, root.drawMarker)		
	}
    
	drawMarker() {
		const root = document.querySelector(`page-detail`)
		const kmlForm = new Tmap.Format.KML({extractStyles:true}).read(this.responseXML)
		const vectorLayer = new Tmap.Layer.Vector(`vectorLayerID`)
        
		root.vectorLayer.forEach(each => {
			each.removeAllFeatures()
		})

		vectorLayer.addFeatures(kmlForm)
		document.querySelector(`page-detail`).map.addLayer(vectorLayer)
		document.querySelector(`page-detail`).map.zoomToExtent(vectorLayer.getDataExtent())
        
		root.vectorLayer.push(vectorLayer)
	}
    
	addMarkerLayer(imgUrl = `http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_a.png`) {		
		this.markerLayer = new Tmap.Layer.Markers(`marker`)
		this.map.addLayer(this.markerLayer)
		this.markerLayers.push(this.markerLayer)		
        
		const size = new Tmap.Size(24, 38)
		const offset = new Tmap.Pixel(-(size.w / 2), -size.h)
		const breweryIcon = new Tmap.Icon(this.logo, new Tmap.Size(50, 50), offset)
        
		this.marker = new Tmap.Marker(new Tmap.LonLat(this.location.lon, this.location.lat).transform(`EPSG:4326`, `EPSG:3857`), breweryIcon)
		this.markerLayer.addMarker(this.marker)

		this.aroundAttraction.forEach(each => {
			const icon = new Tmap.Icon(imgUrl, size, offset)
			this.marker = new Tmap.Marker(new Tmap.LonLat(each.mapx, each.mapy).transform(`EPSG:4326`, `EPSG:3857`), icon)
			this.markerLayer.addMarker(this.marker)
		})					
		this.map.zoomToExtent(this.markerLayer.getDataExtent())
	}
    
	searchPOI(text = `검색할 단어`) {
		const tData = new Tmap.TData()
		const center = this.map.getCenter()
        
		tData.events.register(`onComplete`, tData, this.completeSearchPOI)		
		tData.getPOIDataFromSearch(encodeURIComponent(text), {
			centerLon:center.lon, 
			centerLat:center.lat, 
			reqCoordType:`EPSG3857`, 
			resCoordType:`EPSG3857`,
		})
	}
    
	completeSearchPOI() {
		const poi = this.responseXML.querySelectorAll(`searchPoiInfo pois poi`)
		if (!poi) {
			return
		}	
		console.info(poi)
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

injectGlobal`
[src*="https://storage.googleapis.com/mac-tour-251517.appspot.com/breweries/logo/"] {
    border-radius: 100%;
    overflow: hidden;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.1) inset;
}
`

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
