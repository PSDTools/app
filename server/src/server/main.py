"""The server, it's pretty cool.

It might be made with [FastAPI](https://fastapi.tiangolo.com/) and possibly [Strawberry](https://strawberry.rocks/docs/integrations/fastapi).
"""


from __future__ import annotations

from typing import TYPE_CHECKING

import strawberry
from fastapi import FastAPI
from rich import traceback
from strawberry.fastapi import GraphQLRouter

if TYPE_CHECKING:
    from typing_extensions import Self


@strawberry.type
class Query:
    """A query."""

    def hello(self: Self) -> str:
        """Hello."""
        return "Hello World"


def main() -> None:
    """Run the program."""
    schema = strawberry.Schema(Query)
    graphql_app = GraphQLRouter(schema)

    app: FastAPI = FastAPI()
    app.include_router(graphql_app, prefix="/graphql")


if __name__ == "__main__":
    traceback.install()
    main()
    main()
