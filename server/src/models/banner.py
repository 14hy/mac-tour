from typing import List


class Banner(object):
    def __init__(self, title, url_imgs, context, url_link):
        self.title: str = title
        self.url_link: str = url_link
        self.context: str = context
        self.url_imgs: List[str] = url_imgs

        assert isinstance(self.url_imgs, List), 'Type Error'

    @staticmethod
    def from_dict(source):
        return Banner(**source)

    def to_dict(self):
        return self.__dict__

    def __repr__(self):
        return f'<{self.__class__.__name__}({str(self.__dict__)})>'
