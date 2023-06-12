"""The server, it's pretty cool.

It might be made with [FastAPI](https://fastapi.tiangolo.com/) and possibly [Strawberry](https://strawberry.rocks/docs/integrations/fastapi).
"""


from __future__ import annotations

import uvicorn
from fastapi import FastAPI
from rich import traceback

app: FastAPI = FastAPI()


@app.get("/")
def read_root() -> dict[str, str]:
    """Say hello to the world."""
    return {"Hello": "World"}


def main() -> None:
    """Run the program."""
    uvicorn.run(app, host="localhost", port=8000)


if __name__ == "__main__":
    traceback.install()
    main()
