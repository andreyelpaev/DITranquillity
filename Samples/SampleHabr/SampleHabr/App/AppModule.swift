//
//  AppModule.swift
//  SampleHabr
//
//  Created by Alexander Ivlev on 26/09/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import DITranquillity

class AppModule: DIModule {
  func load(builder: DIContainerBuilder) {
    builder.register(UIStoryboard.self)
      .asName("Main")
      .lifetime(.single)
      .initializer { scope in DIStoryboard(name: "Main", bundle: nil, container: scope) }
    
		builder.register{ YourPresenter(server: *!$0) }
      .lifetime(.perScope)
      .dependency { (scope, self) in self.logger = *?scope }
    
		builder.register(vc: YourViewController.self)
      .dependency { (scope, self) in self.presenter = try! scope.resolve() }
  }

}
