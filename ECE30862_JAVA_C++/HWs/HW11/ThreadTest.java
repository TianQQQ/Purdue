/*
  main.c
  Created by Tian Qiu on 15/4/19.
  Copyright (c) 2015  Tian Qiu. All rights reserved.
*/


public class ThreadTest extends Thread {
    private int threadNo;
    public ThreadTest(int threadNo) {
        this.threadNo = threadNo;
    }
    public static void main(String[] args) throws Exception {
        for (int i = 1; i < 10; i++) {
            new ThreadTest(i).start();
            Thread.sleep(1);
        }
    }
    
    @Override
    public synchronized void run() {
        for (int i = 1; i < 10000; i++) {
            System.out.println("No." + threadNo + ":" + i);
        }
    }
}