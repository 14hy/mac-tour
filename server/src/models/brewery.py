from typing import List


class Brewery(object):
    def __init__(self, name, available, location, desc, home_page,
                 url_img, url_logo, url_apply, region, price, available_day):
        # 양조장 설명
        self.desc: str = desc
        # 투어가 가능한 날
        self.available_day: str = available_day
        # 브루어리 투어 가격
        self.price: int = price
        # 브루어리 지역
        self.region: str = region
        # 브루어리 신청
        self.url_apply: str = url_apply
        # 브루어리 로고
        self.url_logo: str = url_logo
        # 브루어리 이미지
        self.url_img: str = url_img
        # 브루어리 사이트
        self.home_page: str = home_page
        # 브루어리 좌표 mapX(longitude), mapY(latitude)
        # 구글지도와 반대이며 TourAPI 기준으로 등록
        self.location: List[int, int] = location
        # 투어 가능 여부
        self.available: bool = available
        # 투어 이름
        self.name: str = name

        assert isinstance(self.location, List), 'Type Error'

    @staticmethod
    def from_dict(source):
        return Brewery(**source)

    def to_dict(self) -> dict:
        return self.__dict__

    def __repr__(self):
        return f'<{self.__class__.__name__}({str(self.__dict__)})>'
