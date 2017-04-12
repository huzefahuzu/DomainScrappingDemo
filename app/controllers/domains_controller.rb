class DomainsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_domain, only: [:edit, :update, :destroy, :show]

  def add_domains
  end

  def save_domains
  	if params[:domain_1].present?
      domain_1 = sep_domain(params[:domain_1])
      if domain_1.present?
        current_user.domains.first.update(url: domain_1) if current_user.domains.first.present?
        current_user.domains.create(url: domain_1) if current_user.domains.empty?
      end
    end
  end

  def new
    @domain = current_user.domains.new
  end

  def create
    @domain = current_user.domains.new(domain_params)
    @domain.url = sep_domain(params[:domain][:url])
    respond_to do |format|
      if @domain.url.present? && @domain.save
        format.html { redirect_to root_url, notice: 'Domain was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    gen_chart
  end

  def edit
  end

  def update
    respond_to do |format|
      if domain_check_and_update
        format.html { redirect_to root_url, notice: 'Domain was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Domain was successfully destroyed.' }
    end
  end

  private
  def domain_check_and_update
    domain_url = sep_domain(params[:domain][:url])
    if domain_url.present?
      @domain.update(domain_params)
      @domain.update(url: domain_url)
    else
      false
    end
  end

  def sep_domain(domain_url)
    url = Domainatrix.parse(domain_url)
    if url.domain.present?
      url.domain+"."+url.public_suffix
    else
      url.domain
    end
  end

  def set_domain
    @domain = Domain.find(params[:id])
  end

  def domain_params
    params.require(:domain).permit(:url, :name, :description)
  end

  def gen_chart
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "#{@domain.url} day vs rank ")
      f.xAxis(categories: @domain.domain_ranks.collect{|dr| dr.rank_time.strftime("%A")})
      f.series(name: "Rank in Billions", yAxis: 0, data: @domain.domain_ranks.collect(&:rank))

      f.yAxis [
        {title: {text: "Rank in Billions", margin: 70} },
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
        backgroundColor: {
          linearGradient: [0, 0, 500, 500],
          stops: [
            [0, "rgb(255, 255, 255)"],
            [1, "rgb(240, 240, 255)"]
          ]
        },
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end
  end

end
