//
//  ValidatingForms.swift
//  14_Project10_CupcakesCorner
//
//  Created by Jacob Zhang on 2020/5/4.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import SwiftUI

struct ValidatingForms: View {
    @State var username = ""
    @State var email = ""

    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

struct ValidatingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingForms()
    }
}
