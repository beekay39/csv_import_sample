require "csv"
require 'nkf'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  NAME = 0
  NAME_KANA = 1

  def index
    @persons = Person.all
  end
  
  def import_csv
    @persons = Person.all
    if params[:csv]
      # CSVファイル読み込み
      table = CSV.table(params[:csv].path)
      
      # CSVインサート処理
      table.each do | row |
        person = Person.new
        person.name = row[NAME]
        person.kana_name = row[NAME_KANA]
        person.save
      end
      flash.now[:success] = "取り込みに成功しました"
    else
      flash.now[:fail] = "取り込みに失敗しました"
    end
    render "index"
  end
  
end
