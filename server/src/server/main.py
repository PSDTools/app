"""The server, it's pretty cool.

It might be made with [FastAPI](https://fastapi.tiangolo.com/) and possibly [Strawberry](https://strawberry.rocks/docs/integrations/fastapi).
"""


from __future__ import annotations

import asyncio

import uvicorn
from fastapi import FastAPI
from rich import traceback

app: FastAPI = FastAPI()


@app.get("/")
async def read_root() -> dict[str, str]:
    """Say hello to the world."""
    return {"Hello": "World"}


async def main() -> None:
    """Run the program."""
    config = uvicorn.Config(app, port=8080, log_level="info")
    server = uvicorn.Server(config)
    await server.serve()


if __name__ == "__main__":
    traceback.install()
    asyncio.run(main())
