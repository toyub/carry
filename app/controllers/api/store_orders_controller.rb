module Api
  class StoreOrdersController < BaseController

    def index
      @orders = StoreOrder.page(params[:page]).per(10)
      render json: @orders
    end


    def sdfd

        [
         {:customer=>{:name=>"线 余"}, :car_num=>"黑J 9HF2N"},
         {:customer=>{:name=>"佟佳 砉"}, :car_num=>"新N 63UDP"},
         {:customer=>{:name=>"召 寿"}, :car_num=>"桂A B964R"},
         {:customer=>{:name=>"邝 悍"}, :car_num=>"港E AY2UY"},
         {:customer=>{:name=>"舒 谘"}, :car_num=>"辽J 69KD6"},
         {:customer=>{:name=>"蓝 祺"}, :car_num=>"豫G B3YQ4"},
         {:customer=>{:name=>"粘 俓"}, :car_num=>"青D 7DCIO"},
         {:customer=>{:name=>"宗政 悌"}, :car_num=>"辽P 7MXS8"},
         {:customer=>{:name=>"晋 黛荷"}, :car_num=>"鄂S 8FNTZ"},
         {:customer=>{:name=>"果 各"}, :car_num=>"粤N 75DAJ"},
         {:customer=>{:name=>"王 先"}, :car_num=>"台E 9LA01"},
         {:customer=>{:name=>"厉 爸"}, :car_num=>"新Z 9O3U1"},
         {:customer=>{:name=>"娄 眩"}, :car_num=>"赣P B5OUV"},
         {:customer=>{:name=>"载 瑾萱"}, :car_num=>"赣B ABO4G"},
         {:customer=>{:name=>"蒯 巧芳"}, :car_num=>"甘H 9T98U"},
         {:customer=>{:name=>"段干 海颖"}, :car_num=>"沪H B6XGG"},
         {:customer=>{:name=>"周 径"}, :car_num=>"粤M 769AV"},
         {:customer=>{:name=>"泉 瑜"}, :car_num=>"澳J 9CWZT"},
         {:customer=>{:name=>"福 见"}, :car_num=>"沪H 8EC9C"},
         {:customer=>{:name=>"刑 昙"}, :car_num=>"蒙E 9ZIN5"},
         {:customer=>{:name=>"孙 泸"}, :car_num=>"冀Y 8G6C4"},
         {:customer=>{:name=>"艾 开"}, :car_num=>"桂B 9V72W"},
         {:customer=>{:name=>"汝 莆"}, :car_num=>"鲁Z ARK1R"},
         {:customer=>{:name=>"况 芳"}, :car_num=>"沪O 8RG8O"},
         {:customer=>{:name=>"刁 欢旋"}, :car_num=>"赣N 73AZ5"},
         {:customer=>{:name=>"嘉 铤"}, :car_num=>"豫O 77AYS"},
         {:customer=>{:name=>"闪 笆"}, :car_num=>"滇U 6FPRS"},
         {:customer=>{:name=>"同 慕灵"}, :car_num=>"甘N 9AVOT"},
         {:customer=>{:name=>"类 魁"}, :car_num=>"台P 81PH8"},
         {:customer=>{:name=>"道 更"}, :car_num=>"黑I 85GSB"},
         {:customer=>{:name=>"卿 还"}, :car_num=>"宁Z AIPSM"},
         {:customer=>{:name=>"纪 凇"}, :car_num=>"粤J 6U2FL"},
         {:customer=>{:name=>"五 北"}, :car_num=>"苏D 7YRTQ"},
         {:customer=>{:name=>"阴 摹"}, :car_num=>"赣G BHZV4"},
         {:customer=>{:name=>"宗政 筑"}, :car_num=>"鲁M 60576"},
         {:customer=>{:name=>"可 陆"}, :car_num=>"吉U 8R44J"},
         {:customer=>{:name=>"敛 嘉懿"}, :car_num=>"晋W 6O5H8"},
         {:customer=>{:name=>"奚 糯"}, :car_num=>"甘Y 9KB89"},
         {:customer=>{:name=>"邴 蘅"}, :car_num=>"湘V 7WMMV"},
         {:customer=>{:name=>"罕 谌"}, :car_num=>"蜀V 8P9BU"},
         {:customer=>{:name=>"狄 强"}, :car_num=>"京L 6YMX1"},
         {:customer=>{:name=>"凌 丽瑶"}, :car_num=>"冀P 754UB"},
         {:customer=>{:name=>"望 圭"}, :car_num=>"吉E 7VHGC"},
         {:customer=>{:name=>"乜 升"}, :car_num=>"澳O BFNJ7"},
         {:customer=>{:name=>"申屠 皋"}, :car_num=>"赣I 6CP7C"},
         {:customer=>{:name=>"庹 菲裳"}, :car_num=>"湘F BOV0C"},
         {:customer=>{:name=>"藏 法"}, :car_num=>"港W 86V7E"},
         {:customer=>{:name=>"羊舌 佐"}, :car_num=>"粤E 7EXLA"},
         {:customer=>{:name=>"昝 影岚"}, :car_num=>"闽W 9UYSW"},
         {:customer=>{:name=>"诗 臣"}, :car_num=>"粤N ABCL7"}
       ]
    end
  end
end
