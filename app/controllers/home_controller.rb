class HomeController < ApplicationController

  def top
  end
   def result
   			#手の名前、ステータスの管理
			@hand = ["グー","チョキ","パー"]

			#プレイヤー（必殺の手,体力,攻撃,テクニック）
			#プレイヤー1を@a、プレイヤー2を@bと置く。
			@a = [params[:num1],params[:hpt1],params[:atk1],params[:tec1]].map{|w| w=w.to_i}
			@b = [params[:num2],params[:hpt2],params[:atk2],params[:tec2]].map{|w| w=w.to_i}


		   #攻撃と必殺技
		   def attack(playerx,playery)
		     playery[1] -= (playerx[2]*0.3).round
		     playery[1] = 0 if playery[1] < 0
		   end
		   def special(playerx,playery)
		     playery[1] -= (playerx[3]*0.6).round
		     playery[1] = 0 if playery[1] < 0
		   end

		    @log=["戦闘ログ"]
			#じゃんけんメソッドの定義
			#このnum1,num2はプレイヤーの必殺技でなく、それぞれのゲームごとの出した手である。
			@num1=[]
			@num2=[]
			@var=[]
			4.times do |n|
			@num1[n]=params[:a[0]]["#{n}"].to_i
			@num2[n]=params[:b[0]]["#{n}"].to_i
			#a[0]の0はじゃんけんの手の入力ということ。なぜかこうなっただけで特に意味は無い。num1[0]と["0"]における0は、1回目のバトルということ
			@log<< "1Pの手は" + @hand[@num1[n]]+ "です。"
			@log<< "2Pの手は" + @hand[@num2[n]]+ "です。"
				@var[n] = @num1[n] - @num2[n]
				if @var[n] == -1 || @var[n] == 2
					if @num1[n]==@a[n]
					  special(@a,@b)
					  @log<<"1Pの必殺技だ！"
					else
					  attack(@a,@b)
					  @log<<"1Pの攻撃！"
					end
				elsif @var[n] == 1 || @var[n] == -2
					if @num2[n]==@b[n]
					  special(@b,@a)
					  @log<<"2Pの必殺技だ！"
					else
					  attack(@b,@a)
					  @log<<"2Pの攻撃！"
					end
				elsif @var[n] == 0
				  	@log<<"あいこです"
				end
			@log<<"1Pの残り体力" + @a[1].to_s
			@log<<"2Pの残り体力" + @b[1].to_s
			break if @a[1]==0||@b[1]==0
			end
   end
end