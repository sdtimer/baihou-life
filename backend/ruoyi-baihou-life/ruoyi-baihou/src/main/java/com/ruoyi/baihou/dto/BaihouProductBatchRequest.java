package com.ruoyi.baihou.dto;

import java.util.List;

/**
 * Baihou product batch action request.
 */
public class BaihouProductBatchRequest
{
    private List<Long> ids;

    private String action;

    public List<Long> getIds()
    {
        return ids;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

    public String getAction()
    {
        return action;
    }

    public void setAction(String action)
    {
        this.action = action;
    }
}
