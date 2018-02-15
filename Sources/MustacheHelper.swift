//
//  MustacheHelper.swift
//  PerfectLib
//
//  Created by serdar on 14.02.2018.
//

import PerfectMustache

struct MustacheHelper: MustachePageHandler {
    
    var values: MustacheEvaluationContext.MapType
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.appendBody(string: "\(error)")
                .completed(status: .internalServerError)
        }
    }
}
