package cn.com.yunqitong.controller;

import java.io.IOException;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;





import cn.com.yunqitong.service.PayService;
import cn.com.yunqitong.util.HttpsUtil;
import cn.com.yunqitong.util.PropertyFactory;
import cn.com.yunqitong.util.WxUtil;
@RequestMapping(value="/pay")
@Controller
public class PayController {
	@Autowired
	private PayService payService;
	protected Logger log = Logger.getLogger(PayService.class);
	/**
	 * 微信支付方式发起支付请求
	 * @param request 请求数据
	 * @throws IOException 
	 * @return响应数据
	 */
	@RequestMapping(value = "/wx.do")
	public String wxPay(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 获取请求数据
//		String reqText = HttpsUtil.getJsonFromRequest(request);
//		String openId = request.getParameter("code");
		String reqText = "{\"spbill_create_ip\":\"192.168.1.7\", \"body\":\"abc\", \"orderMoney\":1,"
				+ " \"accountId\": \"12334567\", \"openid\":\"ogGs4v73sDPM6w0dpLP7kTELzsuU\"}";
		log.info("request text pay by wx " + reqText);
		JSONObject resText = payService.getWxPayToken(reqText);
//		HttpsUtil.sendAppMessage(resText.toString(), response);
		log.info("resText = " + resText.toString());
		//跳转支付
		SortedMap<Object, Object> finalpackage = new TreeMap<Object, Object>();
		String appid2 = resText.getString("appid");
		String timestamp = resText.getString("timestamp");
		String nonceStr2 = resText.getString("nonce_str");
		String prepay_id2 = "prepay_id="+resText.getString("prepay_id");
		String packages = prepay_id2;
		finalpackage.put("appId", appid2);  
		finalpackage.put("timeStamp", timestamp);  
		finalpackage.put("nonceStr", nonceStr2);  
		finalpackage.put("package", packages);  
		finalpackage.put("signType", "MD5");
//		String finalsign = resText.getString("sign");
		String Key = PropertyFactory.getProperty("KEY");
		String finalsign = WxUtil.createSign("utf-8", finalpackage, Key);
		System.out.println("pay.jsp?appid="+appid2+"&timeStamp="+timestamp+"&nonceStr="+nonceStr2+"&package="+packages+"&sign="+finalsign);
		response.sendRedirect("https://www.good-man.cn/payserver/pay.jsp?appid="+appid2+"&timeStamp="+timestamp+"&nonceStr="+nonceStr2+"&package="+packages+"&sign="+finalsign);
		
		return null;
	}
	/**
	 * 支付宝支付
	 * @param request 接收数据
	 * @return 响应数据
	 */
	@RequestMapping(value = "/ali.do")
	public String aliPay(HttpServletRequest request, HttpServletResponse response) {
		// 获取请求数据
		String reqText = HttpsUtil.getJsonFromRequest(request);
		log.info("request text pay by ali " + reqText);
		JSONObject resText = payService.getAliPayToken(reqText);
		HttpsUtil.sendAppMessage(resText.toString(), response);
		return null;
	}
	
	/**
	 * 获取微信支付结果通知
	 * 		notify
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/result.do")
	public String payResult(HttpServletRequest request, HttpServletResponse response) {
		// 获取请求数据
		String reqText = HttpsUtil.getInfoFromRequest(request);
		log.info("request text from wx " + reqText);
		String res2WX=payService.getPayResult(reqText);
		HttpsUtil.sendAppMessage(res2WX, response);
		return null;
	}
	/**
	 * 接收支付宝支付结果通知
	 * @param request  接收数据
	 * @param response 响应数据
	 * @return
	 */
	@RequestMapping(value = "/aliResult.do")
	public String Test(HttpServletRequest request, HttpServletResponse response) {
		// 获取请求数据
		String reqText = HttpsUtil.getInfoFromRequest(request);
		log.info("request text from alipay " + reqText);
		String res2WX=payService.getAliPayResult(reqText);
		HttpsUtil.sendAppMessage(res2WX, response);
		return null;
	}
}
