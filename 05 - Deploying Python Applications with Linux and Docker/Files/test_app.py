"""Tests for the lab 5 Flask app.

These tests lock in the fix for the JSON double-encoding bug: the template must
receive a real object (single |tojson encoding), not a JSON string that was then
re-encoded. Run with: pytest
"""
import json
import os

import pytest

import app as flask_app


@pytest.fixture
def client():
    flask_app.app.config["TESTING"] = True
    with flask_app.app.test_client() as test_client:
        yield test_client


def test_index_returns_200(client):
    response = client.get("/")
    assert response.status_code == 200


def test_data_is_loaded_as_dict():
    # json.load must produce a dict, not a raw string.
    assert isinstance(flask_app.thisdata, dict)
    assert flask_app.thisdata["squadName"] == "Super hero squad"


def test_page_renders_real_fields(client):
    body = client.get("/").get_data(as_text=True)
    # The squad name and a member name must appear in the rendered page.
    assert "Super hero squad" in body
    assert "Molecule Man" in body


def test_json_is_not_double_encoded(client):
    body = client.get("/").get_data(as_text=True)
    # A double-encoded payload would contain escaped quotes like \" inside the
    # JS string. The single-encoded object uses plain quotes.
    assert '\\"' not in body
    # The object literal must start as a real JS object, not a quoted string.
    assert 'var squad = {' in body


def test_file_json_matches_loaded_data():
    here = os.path.dirname(os.path.abspath(__file__))
    with open(os.path.join(here, "file.json"), "r") as handle:
        on_disk = json.load(handle)
    assert flask_app.thisdata == on_disk
