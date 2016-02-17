/*
  main.c
  Created by Tian Qiu on 15/4/19.
  Copyright (c) 2015  Tian Qiu. All rights reserved.
*/


public class ThreadTest1 extends Thread {
    private int threadNo; private String lock;
    public ThreadTest1(int threadNo, String lock) {
        this.threadNo = threadNo;
        this.lock = lock;   }
    public static void main(String[] args) throws Exception {
        String lock = new String("lock");
        for (int i = 1; i < 10; i++) {
            new ThreadTest1(i, lock).start();
            Thread.sleep(1);
        }
    }
    public void run() {
        synchronized (lock) {
            for (int i = 1; i < 10000; i++) {
                System.out.println("No." + threadNo + ":" + i);
            }      
        }     
    }   
}