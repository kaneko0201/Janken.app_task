class Janken
  Choices = ["グー", "チョキ", "パー"]

  def initialize
    @you = nil
    @opponent = nil
  end

  def call_play
    puts "じゃんけん..."
    puts "0(グー)1(チョキ)2(パー)3(戦わない)"
    janken_type = gets.chomp
    puts "ホイ！"

    if ['0', '1', '2', '3'].include?(janken_type)
      if janken_type == '3'
        puts "じゃんけんを終了します"
        return :exit
      else
        @you = Choices[janken_type.to_i]
        @opponent = Choices.sample
        call_choices
        if @you != @opponent
          return :toDirection
        else
          puts "---------------------------"
        end
      end
    else
      puts "不正な値です"
      puts "0〜3の数字を入力してください"
    end
  end

  def call_choices
      puts "---------------------------"
      puts "あなた：#{@you}を出しました"
      puts "相手：#{@opponent}を出しました"
  end
end

class Direction < Janken
  Option = ["上", "下", "左", "右"]

  def initialize
    super()
    @you_dir = nil
    @opponent_dir = nil
  end

  def call_direction
    puts "---------------------------"
    puts "あっち向いて〜"
    puts "0(上)1(下)2(左)3(右)"
    direction_type = gets.chomp
    puts "ホイ！"

    if ['0', '1', '2', '3'].include?(direction_type)
      @you_dir = Option[direction_type.to_i]
      @opponent_dir = Option.sample

      if (@you == "グー" && @opponent == "チョキ") ||
        (@you == "チョキ" && @opponent == "パー") ||
        (@you == "パー" && @opponent == "グー")
        puts "---------------------------"
        puts "あなた：#{@you_dir}を指しました"
        puts "相手：#{@opponent_dir}を向きました"

        if @you_dir == @opponent_dir
          puts "あなたの勝ちです！"
          return :close
        end
      elsif @you != @opponent
        puts "---------------------------"
        puts "あなた：#{@you_dir}を向きました"
        puts "相手：#{@opponent_dir}を指しました"

        if @you_dir == @opponent_dir
          puts "あなたの負けです"
          return :close
        end
      end
    else
      puts "不正な値です"
      puts "0〜3の数字を入力してください"
    end
  end
end

direct = Direction.new

loop do
  result = direct.call_play

  if result == :toDirection
    direction_result = direct.call_direction
    break if direction_result == :close
  elsif result == :exit
    break
  end
end
