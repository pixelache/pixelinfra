# -*- encoding : utf-8 -*-
class Admin::WikifilesController < Admin::BaseController
  before_action :authenticate_user!
  load_and_authorize_resource
end
