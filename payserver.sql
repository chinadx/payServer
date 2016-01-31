/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.7
Source Server Version : 50546
Source Host           : 192.168.1.7:3306
Source Database       : payserver

Target Server Type    : MYSQL
Target Server Version : 50546
File Encoding         : 65001

Date: 2016-01-31 16:23:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_ali_order
-- ----------------------------
DROP TABLE IF EXISTS `t_ali_order`;
CREATE TABLE `t_ali_order` (
  `aid` varchar(32) NOT NULL DEFAULT '',
  `service` varchar(32) DEFAULT NULL,
  `partner` varchar(16) DEFAULT NULL,
  `_input_charset` varchar(16) DEFAULT NULL,
  `sign_type` varchar(16) DEFAULT NULL,
  `sign` varchar(32) DEFAULT NULL,
  `notify_url` varchar(200) DEFAULT NULL,
  `app_id` varchar(32) DEFAULT NULL,
  `appenv` varchar(32) DEFAULT NULL,
  `out_trade_no` varchar(32) DEFAULT NULL,
  `subject` varchar(128) DEFAULT NULL,
  `payment_type` varchar(4) DEFAULT NULL,
  `seller_id` varchar(16) DEFAULT NULL,
  `total_fee` bigint(20) DEFAULT NULL,
  `body` varchar(512) DEFAULT NULL,
  `goods_type` varchar(2) DEFAULT NULL,
  `rn_check` varchar(2) DEFAULT NULL,
  `it_b_pay` varchar(32) DEFAULT NULL,
  `extern_token` varchar(32) DEFAULT NULL,
  `out_context` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_order_record
-- ----------------------------
DROP TABLE IF EXISTS `t_order_record`;
CREATE TABLE `t_order_record` (
  `oid` varchar(32) NOT NULL COMMENT '订单记录的主键 id',
  `device_info` varchar(64) DEFAULT NULL COMMENT '设备号  终端设备号(门店号或收银设备ID)，PC网页或公众号内支付为WEB',
  `nonce_str` varchar(32) NOT NULL COMMENT '机字符串随',
  `sign` varchar(32) NOT NULL COMMENT '签名',
  `body` varchar(128) NOT NULL COMMENT '品商描述',
  `detail` varchar(8192) DEFAULT NULL COMMENT '品商详细列表',
  `attach` varchar(127) DEFAULT NULL COMMENT '加附数据',
  `out_trade_no` varchar(32) NOT NULL COMMENT '单号订',
  `fee_type` varchar(16) DEFAULT NULL COMMENT '货币类型',
  `total_fee` bigint(11) NOT NULL COMMENT '金额总',
  `spbill_create_ip` varchar(16) NOT NULL COMMENT '端终ip  APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。',
  `time_start` varchar(14) DEFAULT NULL COMMENT '易交起始时间',
  `time_expire` varchar(14) DEFAULT NULL COMMENT '易交结束时间',
  `goods_tag` varchar(32) DEFAULT NULL COMMENT '商品标记',
  `trade_type` varchar(16) NOT NULL COMMENT '易交类型',
  `product_id` varchar(32) DEFAULT NULL COMMENT '品商 id  native  扫码支付用',
  `limit_pay` varchar(32) DEFAULT NULL COMMENT 'on-credit 为不支持信用卡  限制支付方式',
  `openid` varchar(128) DEFAULT NULL COMMENT '户用标识   公众账号的关注者的id',
  `status` int(8) DEFAULT '0' COMMENT '易交状态  或者说交易结果 0 未完成 1 已完成 2.已关闭',
  `accept_content` varchar(256) DEFAULT NULL COMMENT '现阶段主要存储AS发送过来的请求数据',
  `accountid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_wx_record
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_record`;
CREATE TABLE `t_wx_record` (
  `id` varchar(32) NOT NULL COMMENT 'id 主键',
  `return_msg` varchar(128) DEFAULT NULL COMMENT '返回信息',
  `device_info` varchar(32) DEFAULT NULL COMMENT '设备号',
  `nonce_str` varchar(32) NOT NULL COMMENT '随机字符串',
  `sign` varchar(32) NOT NULL COMMENT '签名',
  `result_code` varchar(16) NOT NULL COMMENT '业务结果',
  `err_code` varchar(32) DEFAULT NULL COMMENT '错误代码',
  `err_code_msg` varchar(128) DEFAULT NULL COMMENT '错误代码描述',
  `openid` varchar(128) NOT NULL COMMENT '用户标识',
  `is_subscribe` varchar(2) DEFAULT NULL COMMENT '是否关注公众账号',
  `trade_type` varchar(16) NOT NULL COMMENT '交易类型',
  `bank_type` varchar(16) NOT NULL COMMENT '付款银行',
  `total_fee` int(11) NOT NULL COMMENT '总金额',
  `fee_type` varchar(8) DEFAULT NULL COMMENT '货币种类',
  `cash_fee` int(11) NOT NULL COMMENT '现金支付金额',
  `cash_fee_type` varchar(16) DEFAULT NULL COMMENT '现金支付货币类型',
  `coupon_fee` int(11) NOT NULL COMMENT '代金券或立减优惠金额',
  `coupon_count` int(11) DEFAULT NULL COMMENT '代金券或立减优惠使用数量',
  `coupon_id_$n` varchar(20) DEFAULT NULL COMMENT '代金券或立减优惠ID',
  `coupon_fee_$n` int(11) DEFAULT NULL COMMENT '单个代金券或立减优惠支付金额',
  `transaction_id` varchar(32) NOT NULL COMMENT '微信支付订单号',
  `out_trade_no` varchar(32) NOT NULL COMMENT '商户订单号',
  `attach` varchar(128) DEFAULT NULL COMMENT '商家数据包',
  `time_end` varchar(14) NOT NULL COMMENT '支付完成时间',
  `updatetime` varchar(32) DEFAULT NULL COMMENT '状态更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
