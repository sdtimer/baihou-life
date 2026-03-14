package com.ruoyi.baihou.vo.miniapp;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.ruoyi.baihou.domain.BaihouOrder;

/**
 * 小程序订单 VO（snake_case 字段名）
 */
public class MiniOrderVO
{
    @JsonProperty("order_id")
    private Long orderId;

    @JsonProperty("order_no")
    private String orderNo;

    @JsonProperty("region_id")
    private String regionId;

    @JsonProperty("total_amount")
    private BigDecimal totalAmount;

    @JsonProperty("pay_amount")
    private BigDecimal payAmount;

    private String status;

    @JsonProperty("expires_at")
    private Date expiresAt;

    @JsonProperty("create_time")
    private Date createTime;

    public static MiniOrderVO from(BaihouOrder o)
    {
        MiniOrderVO vo = new MiniOrderVO();
        vo.orderId = o.getOrderId();
        vo.orderNo = o.getOrderNo();
        vo.regionId = o.getRegionId();
        vo.totalAmount = o.getTotalAmount();
        vo.payAmount = o.getPayAmount();
        vo.status = o.getStatus();
        vo.expiresAt = o.getExpiresAt();
        vo.createTime = o.getCreateTime();
        return vo;
    }

    public Long getOrderId() { return orderId; }
    public String getOrderNo() { return orderNo; }
    public String getRegionId() { return regionId; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public BigDecimal getPayAmount() { return payAmount; }
    public String getStatus() { return status; }
    public Date getExpiresAt() { return expiresAt; }
    public Date getCreateTime() { return createTime; }
}
