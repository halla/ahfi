defmodule Ahfi.CMSTest do
  use Ahfi.DataCase

  alias Ahfi.CMS

  describe "media" do
    alias Ahfi.CMS.Media

    @valid_attrs %{filename: "some filename"}
    @update_attrs %{filename: "some updated filename"}
    @invalid_attrs %{filename: nil}

    def media_fixture(attrs \\ %{}) do
      {:ok, media} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_media()

      media
    end

    test "list_media/0 returns all media" do
      media = media_fixture()
      assert CMS.list_media() == [media]
    end

    test "get_media!/1 returns the media with given id" do
      media = media_fixture()
      assert CMS.get_media!(media.id) == media
    end

    test "create_media/1 with valid data creates a media" do
      assert {:ok, %Media{} = media} = CMS.create_media(@valid_attrs)
      assert media.filename == "some filename"
    end

    test "create_media/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_media(@invalid_attrs)
    end

    test "update_media/2 with valid data updates the media" do
      media = media_fixture()
      assert {:ok, media} = CMS.update_media(media, @update_attrs)
      assert %Media{} = media
      assert media.filename == "some updated filename"
    end

    test "update_media/2 with invalid data returns error changeset" do
      media = media_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_media(media, @invalid_attrs)
      assert media == CMS.get_media!(media.id)
    end

    test "delete_media/1 deletes the media" do
      media = media_fixture()
      assert {:ok, %Media{}} = CMS.delete_media(media)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_media!(media.id) end
    end

    test "change_media/1 returns a media changeset" do
      media = media_fixture()
      assert %Ecto.Changeset{} = CMS.change_media(media)
    end
  end

  describe "pages" do
    alias Ahfi.CMS.Page

    @valid_attrs %{body: "some body", title: "some title"}
    @update_attrs %{body: "some updated body", title: "some updated title"}
    @invalid_attrs %{body: nil, title: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert CMS.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert CMS.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = CMS.create_page(@valid_attrs)
      assert page.body == "some body"
      assert page.title == "some title"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = CMS.update_page(page, @update_attrs)
      assert %Page{} = page
      assert page.body == "some updated body"
      assert page.title == "some updated title"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_page(page, @invalid_attrs)
      assert page == CMS.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = CMS.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = CMS.change_page(page)
    end
  end
end
