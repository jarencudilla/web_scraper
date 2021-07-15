class WebScraperController < ApplicationController
  def index
  end

  def new
    Web Scrapper.crawl!
    end
