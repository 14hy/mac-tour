from functools import wraps
from typing import Callable
from time import time
from datetime import timezone, timedelta, datetime
import logging
from config import Config as _CONF

KST = timezone(offset=timedelta(hours=9))

formatter = logging.Formatter('[%(asctime)s] - %(name)s - %(levelname)s in %(message)s')

handler = logging.StreamHandler()
handler.setFormatter(formatter)

logger = logging.getLogger('my-logger')
logger.setLevel(_CONF.level)
logger.addHandler(handler)

logger.info('my-logger started')


def basic_logger(fn: Callable):
    """Logger decorator"""

    @wraps(fn)
    def wrapper(*args, **kwargs):
        ret = fn(*args, **kwargs)
        logger.debug(f'in {fn.__name__}, args: {args}, kwargs: {kwargs}, return: {ret}')
        return ret

    return wrapper


def basic_timer(fn: Callable):
    """Timer decorator"""

    @wraps(fn)
    def wrapper(*args, **kwargs):
        start = time()
        ret = fn(*args, **kwargs)
        end = time()
        logger.debug(f'in {fn.__name__}, Total execution time: {end - start}')
        return ret

    return wrapper
