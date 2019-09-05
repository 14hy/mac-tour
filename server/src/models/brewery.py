from typing import List


class Brewery(object):
    def __init__(self, name, available, location, desc, home_page,
                 url_img, url_logo, url_apply, region, price, available_day):
        self.desc: str = desc
        self.available_day: str = available_day
        self.price: int = price
        self.region: str = region
        self.url_apply: str = url_apply
        self.url_logo: str = url_logo
        self.url_img: str = url_img
        self.home_page: str = home_page
        self.location: List[int, int] = location  # TODO 좌표로 바뀔것
        self.available: bool = available
        self.name: str = name

        assert isinstance(self.location, List), 'Type Error'

    @staticmethod
    def from_dict(source):
        return Brewery(**source)

    def to_dict(self):
        return self.__dict__

    def __repr__(self):
        return f'<{self.__class__.__name__}({str(self.__dict__)})>'
