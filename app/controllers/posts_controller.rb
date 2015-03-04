# encoding: utf-8
class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @tags = Tag.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    tag = find_param_tag
    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        tag.each do |t|
          @post.taggings.create(tag_id: t)
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    # debugger
    @post = Post.find(params[:id])
    tag = find_param_tag
    # post_tag = @post.tags.map(&:id)
    # post_tag_size = post_tag.size
    respond_to do |format|
      @post.taggings.destroy_all
      tag.each do |t|
        @post.taggings.create(tag_id: t)
      end
      if @post.update_attributes(params[:post])
        # if tag && post_tag_size == tag.size && (post_tag <=> tag) == 0
        # elsif true
        # else
        # end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  def get_post_param
    _params = params[:post]
    keys = [:title, :content, :start_on, :time_zone]
    tag =  params[:post][:tags].length > 0 ? params[:post][:tags].split(',').map(&:to_i) : nil
    attrs = _params.slice(*keys)
  end

  def find_param_tag
    params[:tags].length > 0 ? params[:tags].split(',').map(&:to_i) : nil
  end
end
