class PlayController < ApplicationController

def loadll
  user=User.find(session[:user_id])
  @attempt=Attempt.find_by(uname: user.name,gname: params[:gname], sname: params[:sname])
  if @attempt
    render json:{arr: [@attempt.llpass,@attempt.ll50]}
  else
    render json:{arr: [0,0]}
  end
end

def quizstatus
  @attempted=[]
  @notattempted=[]
  user=User.find(session[:user_id])
  subgenre = Subgenre.all
  old=''
  all=Attempt.where(:uname => user.name).sort_by &:score
  all.each do |a|
    if a.sname.to_s != old.to_s
      @attempted << a
      old =a.sname.to_s
    end
  end
  subgenre.each do |s|
    if Attempt.find_by(uname: user.name,sname: s.name)==nil
      @notattempted << s
    end
  end
end

def getchart
  array=[["Subgenre::Genre","Score"]]
  subgenre=Subgenre.all
  user=User.find(session[:user_id])
  subgenre.each do |s|
    temp=[]
    temp <<  s.name
    if a=Attempt.find_by(uname: user.name,sname: s.name,gname: s.gname)
      temp << a.score.to_f
    else
      temp << 0
    end
    array << temp
  end
  render json: array
end

def leaderboard
  @query=[]
  score=[]
  oldusername=''
  @leader=Attempt.where(:gname => params[:gname],:sname => params[:sname]).sort_by &:score
  @leader=@leader.reverse
  @leader.each do |l|
    if l.uname.to_s != oldusername.to_s
      @query << l
      oldusername=l.uname.to_s
    end
  end
end

  def updateattempt
    user=User.find(session[:user_id])
    @toupdate=Attempt.where(:uname => user.name,:gname => params[:gname],:sname => params[:sname])
    @toupdate.each do |tou|
      tou.update(:score => tou.score+20*params[:status].to_f,:llpass => params[:passflag].to_f,:ll50 => params[:flag50].to_f)
    end
    @toupdate=Attempt.where(:qid => params[:qid], :uname => user.name,:gname => params[:gname],:sname => params[:sname])
    @toupdate[0].update(:attempt => @toupdate[0].attempt+1,:correct => params[:status])
  end

  def getquestion
    $flag=0
    $score=0
    ques=nil
    curuser=User.find_by(id: session[:user_id])
    @questions =Question.where(:gname => params[:gname],:sname => params[:sname])

    if Attempt.find_by(uname: curuser.name ,gname: params[:gname],sname: params[:sname]) == nil
      $flag=1
      @questions.each do |q|
        Attempt.create({qid: q.id,uname: curuser.name,gname: params[:gname],sname: params[:sname],score: 0,attempt: 0,correct: 0,llpass: 0,ll50: 0})
        ques=Question.find_by(id: Attempt.find_by(uname: curuser.name,gname: params[:gname], sname: params[:sname],attempt: 0).qid)
      end
    elsif Attempt.where(:uname => curuser.name,:gname => params[:gname], :sname => params[:sname],:correct => 1).length == @questions.length
      $flag=2
      $score=Attempt.find_by(uname: curuser.name,gname: params[:gname], sname: params[:sname]).score.to_f
    else
      (0..1).each do |i|
        atmpt=Attempt.find_by(uname: curuser.name,gname: params[:gname], sname: params[:sname], attempt: i,correct: 0)
        if atmpt
          ques=Question.find_by(id: atmpt.qid)
          $flag=1
          $score=atmpt.score.to_f
          break
        end
      end
      $score=Attempt.find_by(uname: curuser.name,gname: params[:gname], sname: params[:sname]).score.to_f
    end
    render json: {arr: [{flag: $flag.to_f}, {question: ques},{score: $score.to_f}]}
  end

  def index
    @user=User.find_by(id: session[:user_id])
    
    @genre=Genre.find_by(name: params[:gname])
    
    @subgenre=Subgenre.find_by(name: params[:sname])

    @attempt=Attempt.find_by(uname: @user.name,sname: params[:sname],gname: params[:gname])
    
  end

    def gotohomepage
        redirect_to "/homepage"
    end

  private
    def play_params
      params.require(:play).permit(:gname, :sname)
    end
end