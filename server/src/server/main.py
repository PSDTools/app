from aiohttp import web
from rich import traceback


async def handle(request):
    name = request.match_info.get("name", "Anonymous")
    text = "Hello, " + name
    return web.Response(text=text)


app = web.Application()
app.add_routes([web.get("/", handle), web.get("/{name}", handle)])


def main():
    web.run_app(app)


if __name__ == "__main__":
    traceback.install()
    main()
