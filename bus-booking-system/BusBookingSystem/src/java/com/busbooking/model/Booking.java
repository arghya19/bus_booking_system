package com.busbooking.model;

public class Booking {
    private String bid;
    private String uid;
    private String from;
    private String to;
    private String date;
    private String time;
    private String status;

    public String getBid() { return bid; }
    public void setBid(String bid) { this.bid = bid; }

    public String getFrom() { return from; }
    public void setFrom(String from) { this.from = from; }

    public String getTo() { return to; }
    public void setTo(String to) { this.to = to; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public void setId(int aInt) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
