package com.ruoyi.baihou.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * Baihou order domain.
 */
public class BaihouOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long orderId;

    private String orderNo;

    private Long userId;

    private String regionId;

    private BigDecimal totalAmount;

    private BigDecimal payAmount;

    private String status;

    private String paymentMethod;

    private String transactionId;

    private String remark;

    private String adminNote;

    private String trackingNo;

    private Date paidAt;

    private Date shippedAt;

    private Date completedAt;

    private Date closedAt;

    private Date expiresAt;

    public BaihouOrder()
    {
    }

    public BaihouOrder(Long orderId, String orderNo, String status)
    {
        this.orderId = orderId;
        this.orderNo = orderNo;
        this.status = status;
    }

    public Long getOrderId()
    {
        return orderId;
    }

    public void setOrderId(Long orderId)
    {
        this.orderId = orderId;
    }

    public String getOrderNo()
    {
        return orderNo;
    }

    public void setOrderNo(String orderNo)
    {
        this.orderNo = orderNo;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getRegionId()
    {
        return regionId;
    }

    public void setRegionId(String regionId)
    {
        this.regionId = regionId;
    }

    public BigDecimal getTotalAmount()
    {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount)
    {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getPayAmount()
    {
        return payAmount;
    }

    public void setPayAmount(BigDecimal payAmount)
    {
        this.payAmount = payAmount;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getPaymentMethod()
    {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod)
    {
        this.paymentMethod = paymentMethod;
    }

    public String getTransactionId()
    {
        return transactionId;
    }

    public void setTransactionId(String transactionId)
    {
        this.transactionId = transactionId;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public String getAdminNote()
    {
        return adminNote;
    }

    public void setAdminNote(String adminNote)
    {
        this.adminNote = adminNote;
    }

    public String getTrackingNo()
    {
        return trackingNo;
    }

    public void setTrackingNo(String trackingNo)
    {
        this.trackingNo = trackingNo;
    }

    public Date getPaidAt()
    {
        return paidAt;
    }

    public void setPaidAt(Date paidAt)
    {
        this.paidAt = paidAt;
    }

    public Date getShippedAt()
    {
        return shippedAt;
    }

    public void setShippedAt(Date shippedAt)
    {
        this.shippedAt = shippedAt;
    }

    public Date getCompletedAt()
    {
        return completedAt;
    }

    public void setCompletedAt(Date completedAt)
    {
        this.completedAt = completedAt;
    }

    public Date getClosedAt()
    {
        return closedAt;
    }

    public void setClosedAt(Date closedAt)
    {
        this.closedAt = closedAt;
    }

    public Date getExpiresAt()
    {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt)
    {
        this.expiresAt = expiresAt;
    }
}
