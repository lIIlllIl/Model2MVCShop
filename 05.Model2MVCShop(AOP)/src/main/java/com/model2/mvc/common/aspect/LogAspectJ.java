package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

public class LogAspectJ {

	public LogAspectJ() {
		System.out.println("\nCommon :: " + this.getClass()+"\n");
	}
	
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
		System.out.println("\n[Around before] Target Obeject Metohd : " + 
					joinPoint.getTarget().getClass() + 
					joinPoint.getSignature().getName());
	
		if(joinPoint.getArgs().length != 0) {
			System.out.println("[Around before] Method에 전달되는 인자 : " + joinPoint.getArgs()[0]);
		}
		
		Object obj = joinPoint.proceed();
		
		System.out.println("[Around after] Target Object Return Value : " + obj + "\n");
		
		return obj;
		
			
	}

}
