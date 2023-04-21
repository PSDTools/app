"""This is the server

It might be made with [FastAPI](https://fastapi.tiangolo.com/) and possibly [Strawberry](https://strawberry.rocks/docs/integrations/fastapi).
"""


from aiohttp import web
from rich import traceback


async def handle(request):
    """Handle requests with [aiohttp](https://docs.aiohttp.org/en/stable/)."""
    name = request.match_info.get("name", "Anonymous")
    text = "Hello, " + name
    return web.Response(text=text)


app = web.Application()
app.add_routes([web.get("/", handle), web.get("/{name}", handle)])


def main():
    """The main function of the program."""
    web.run_app(app)


if __name__ == "__main__":
    traceback.install()
    main()
