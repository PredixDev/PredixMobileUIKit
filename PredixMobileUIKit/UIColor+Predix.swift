//
//  Colors.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 9/15/17.
//  Copyright © 2017 GE. All rights reserved.
//
// swiftlint:disable nesting file_length

import Foundation

extension UIColor {

    /// Predix Color Palette
    public enum Predix {

        static private func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {

            return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)

        }

        /*
         * Neutral Palette (gray20 is darkest, gray1 is lightest)
         */
        /// Neutral Palette black
        public static let black                          = rgb(0, 0, 0)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray20                         = rgb(5, 9, 12)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray19                         = rgb(12, 20, 25)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray18                         = rgb(18, 31, 38)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray17                         = rgb(27, 42, 51)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray16                         = rgb(35, 52, 63)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray15                         = rgb(44, 64, 76)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray14                         = rgb(54, 76, 89)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray13                         = rgb(66, 88, 102)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray12                         = rgb(79, 100, 114)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray11                         = rgb(89, 113, 127)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray10                         = rgb(103, 126, 140)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray9                          = rgb(116, 139, 153)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray8                          = rgb(136, 154, 165)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray7                          = rgb(150, 168, 178)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray6                          = rgb(163, 181, 191)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray5                          = rgb(182, 195, 204)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray4                          = rgb(197, 209, 216)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray3                          = rgb(216, 224, 229)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray2                          = rgb(226, 232, 237)
        /// Neutral Palette gray (1 is lightest, 20 is darkest)
        public static let gray1                          = rgb(235, 239, 242)
        /// Neutral Palette white
        public static let white                          = rgb(255, 255, 255)

        /**
         * Actionable Palette
         */
        public enum Primary {
            /// Default Actionable color
            public static let `default`                = rgb(0, 122, 204)
            /// Hover Actionable color
            public static let hover                  = rgb(0, 92, 153)
            /// Pressed Actionable color
            public static let pressed                = rgb(0, 61, 102)
            /// Light Actionable color
            public static let light                  = rgb(238, 251, 255)
        }

        /**
         * Selection Palette
         */
        public enum Select {
            /// Default Selection color
            public static let `default`                 = rgb(9, 129, 156)
            /// Hover Selection color
            public static let hover                   = rgb(6, 87, 105)
            /// Pressed Selection color
            public static let pressed                 = rgb(3, 44, 54)
            /// Light Selection color
            public static let light                   = rgb(230, 251, 255)
        }

        /**
         * Dark Actionable Palette
         */
        public enum Actionable {
            /// Default Dark Actionable color
            public static let `default`             = rgb(69, 172, 229)
            /// Hover Dark Actionable color
            public static let hover               = rgb(45, 115, 153)
            /// Pressed Dark Actionable color
            public static let pressed             = rgb(30, 77, 102)
        }

        /**
         * Alerts and Status
         */
       public enum Status {
            /// Red status (1 is lightest, 4 is darkest)
            public static let red1                    = rgb(255, 236, 236)
            /// Red status (1 is lightest, 4 is darkest)
            public static let red2                    = rgb(249, 165, 159)
            /// Red status (1 is lightest, 4 is darkest)
            public static let red3                    = rgb(243, 67, 54)
            /// Red status (1 is lightest, 4 is darkest)
            public static let red4                    = rgb(180, 0, 0)
            /// Orange status (1 is lightest, 4 is darkest)
            public static let orange1                 = rgb(255, 240, 230)
            /// Orange status (1 is lightest, 4 is darkest)
            public static let orange2                 = rgb(255, 196, 153)
            /// Orange status (1 is lightest, 4 is darkest)
            public static let orange3                 = rgb(255, 139, 58)
            /// Orange status (1 is lightest, 4 is darkest)
            public static let orange4                 = rgb(204, 85, 0)
            /// Yellow status (1 is lightest, 4 is darkest)
            public static let yellow1                 = rgb(255, 246, 217)
            /// Yellow status (1 is lightest, 4 is darkest)
            public static let yellow2                 = rgb(255, 224, 112)
            /// Yellow status (1 is lightest, 4 is darkest)
            public static let yellow3                 = rgb(254, 198, 0)
            /// Yellow status (1 is lightest, 4 is darkest)
            public static let yellow4                 = rgb(163, 128, 1)
            /// Blue status (1 is lightest, 4 is darkest)
            public static let blue1                   = rgb(230, 245, 255)
            /// Blue status (1 is lightest, 4 is darkest)
            public static let blue2                   = rgb(88, 171, 238)
            /// Blue status (1 is lightest, 4 is darkest)
            public static let blue3                   = rgb(20, 121, 201)
            /// Blue status (1 is lightest, 4 is darkest)
            public static let blue4                   = rgb(12, 66, 111)
            /// Green status (1 is lightest, 4 is darkest)
            public static let green1                  = rgb(236, 255, 238)
            /// Green status (1 is lightest, 4 is darkest)
            public static let green2                  = rgb(180, 227, 79)
            /// Green status (1 is lightest, 4 is darkest)
            public static let green3                  = rgb(127, 174, 27)
            /// Green status (1 is lightest, 4 is darkest)
            public static let green4                  = rgb(66, 88, 14)
        }

        /*
         * Data Visualization
         */
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange1                    = rgb(244, 210, 173)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange2                    = rgb(242, 200, 154)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange3                    = rgb(240, 191, 136)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange4                    = rgb(236, 175, 104)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange5                    = rgb(233, 162, 75)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange6                    = rgb(226, 141, 23)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange7                    = rgb(196, 122, 20)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange8                    = rgb(149, 92, 17)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange9                    = rgb(124, 77, 16)
        ///Data Visualization Palette
        ///
        ///Orange (1 is lightest, 10 is darkest)
        public static let orange10                   = rgb(97, 60, 13)
        /*
         * Yellow
         */
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow1                    = rgb(239, 232, 165)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow2                    = rgb(235, 227, 147)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow3                    = rgb(232, 224, 130)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow4                    = rgb(225, 215, 94)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow5                    = rgb(219, 209, 57)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow6                    = rgb(211, 200, 0)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow7                    = rgb(180, 171, 0)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow8                    = rgb(138, 131, 0)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow9                    = rgb(115, 109, 0)
        ///Data Visualization Palette
        ///
        ///Yellow (1 is lightest, 10 is darkest)
        public static let yellow10                   = rgb(89, 85, 2)
        /*
         * Yellow Green
         */
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen1              = rgb(187, 226, 151)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen2              = rgb(174, 220, 128)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen3              = rgb(164, 215, 107)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen4              = rgb(146, 206, 64)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen5              = rgb(134, 198, 0)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen6              = rgb(123, 188, 0)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen7              = rgb(103, 159, 0)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen8              = rgb(79, 123, 0)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen9              = rgb(64, 102, 0)
        ///Data Visualization Palette
        ///
        ///Yellow Green (1 is lightest, 10 is darkest)
        public static let yellowGreen10             = rgb(50, 80, 0)
        
        /*
         * Green
         */
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green1                     = rgb(189, 212, 181)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green2                     = rgb(176, 204, 166)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green3                     = rgb(164, 196, 151)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green4                     = rgb(142, 180, 124)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green5                     = rgb(123, 166, 98)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green6                     = rgb(101, 149, 64)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green7                     = rgb(85, 126, 54)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green8                     = rgb(66, 98, 42)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green9                     = rgb(53, 80, 35)
        ///Data Visualization Palette
        ///
        ///Green (1 is lightest, 10 is darkest)
        public static let green10                    = rgb(42, 64, 27)

        /*
         * Teal
         */
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal1                      = rgb(201, 227, 223)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal2                      = rgb(174, 213, 207)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal3                      = rgb(147, 200, 191)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal4                      = rgb(120, 186, 175)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal5                      = rgb(93, 172, 159)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal6                      = rgb(77, 151, 139)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal7                      = rgb(62, 121, 111)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal8                      = rgb(49, 94, 87)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal9                      = rgb(35, 67, 62)
        ///Data Visualization Palette
        ///
        ///Teal (1 is lightest, 10 is darkest)
        public static let teal10                     = rgb(21, 40, 37)
        
        /*
         * Aqua
         */
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua1                      = rgb(182, 206, 221)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua2                      = rgb(168, 196, 214)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua3                      = rgb(153, 186, 208)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua4                      = rgb(125, 167, 195)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua5                      = rgb(103, 151, 184)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua6                      = rgb(72, 130, 168)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua7                      = rgb(62, 112, 145)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua8                      = rgb(46, 84, 109)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua9                      = rgb(38, 69, 90)
        ///Data Visualization Palette
        ///
        ///Aqua (1 is lightest, 10 is darkest)
        public static let aqua10                     = rgb(30, 55, 71)
        
        /*
         * Cyan
         */
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan1                      = rgb(181, 229, 253)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan2                      = rgb(166, 223, 252)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan3                      = rgb(153, 218, 251)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan4                      = rgb(130, 210, 251)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan5                      = rgb(111, 201, 250)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan6                      = rgb(90, 191, 248)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan7                      = rgb(77, 164, 213)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan8                      = rgb(59, 126, 164)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan9                      = rgb(47, 103, 135)
        ///Data Visualization Palette
        ///
        ///Cyan (1 is lightest, 10 is darkest)
        public static let cyan10                     = rgb(36, 80, 105)
        
        /*
         * Blue
         */
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue1                      = rgb(197, 205, 255)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue2                      = rgb(185, 195, 255)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue3                      = rgb(173, 185, 255)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue4                      = rgb(149, 167, 255)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue5                      = rgb(128, 152, 255)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue6                      = rgb(97, 132, 255)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue7                      = rgb(82, 111, 218)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue8                      = rgb(64, 86, 170)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue9                      = rgb(54, 72, 142)
        ///Data Visualization Palette
        ///
        ///Blue (1 is lightest, 10 is darkest)
        public static let blue10                     = rgb(43, 58, 114)
        
        /*
         * Violet
         */
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet1                    = rgb(217, 198, 249)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet2                    = rgb(210, 187, 249)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet3                    = rgb(204, 177, 247)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet4                    = rgb(191, 158, 244)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet5                    = rgb(180, 140, 242)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet6                    = rgb(166, 119, 239)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet7                    = rgb(140, 101, 203)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet8                    = rgb(107, 76, 155)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet9                    = rgb(89, 64, 128)
        ///Data Visualization Palette
        ///
        ///Violet (1 is lightest, 10 is darkest)
        public static let violet10                   = rgb(70, 50, 102)
        
        /*
         * Purple
         */
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple1                    = rgb(236, 191, 229)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple2                    = rgb(233, 180, 224)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple3                    = rgb(231, 168, 219)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple4                    = rgb(227, 147, 210)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple5                    = rgb(224, 129, 201)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple6                    = rgb(219, 106, 188)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple7                    = rgb(187, 90, 159)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple8                    = rgb(144, 69, 123)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple9                    = rgb(119, 57, 102)
        ///Data Visualization Palette
        ///
        ///Purple (1 is lightest, 10 is darkest)
        public static let purple10                   = rgb(96, 46, 82)
        
        /*
         * Pink
         */
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink1                      = rgb(232, 165, 200)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink2                      = rgb(229, 148, 189)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink3                      = rgb(226, 132, 178)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink4                      = rgb(223, 102, 155)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink5                      = rgb(222, 82, 136)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink6                      = rgb(222, 67, 119)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink7                      = rgb(188, 56, 94)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink8                      = rgb(145, 41, 72)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink9                      = rgb(120, 33, 60)
        ///Data Visualization Palette
        ///
        ///Pink (1 is lightest, 10 is darkest)
        public static let pink10                     = rgb(95, 24, 48)
        
        /*
         * Red
         */
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red1                       = rgb(237, 182, 189)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red2                       = rgb(235, 169, 176)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red3                       = rgb(233, 155, 163)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red4                       = rgb(229, 129, 137)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red5                       = rgb(227, 110, 116)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red6                       = rgb(224, 84, 85)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red7                       = rgb(190, 71, 72)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red8                       = rgb(144, 53, 55)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red9                       = rgb(120, 44, 46)
        ///Data Visualization Palette
        ///
        ///Red (1 is lightest, 10 is darkest)
        public static let red10                      = rgb(97, 35, 37)

        /*
         * Brown
         */
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown1                     = rgb(225, 211, 176)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown2                     = rgb(220, 202, 160)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown3                     = rgb(214, 194, 143)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown4                     = rgb(202, 178, 114)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown5                     = rgb(192, 164, 85)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown6                     = rgb(178, 145, 46)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown7                     = rgb(151, 123, 39)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown8                     = rgb(116, 94, 31)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown9                     = rgb(96, 78, 26)
        ///Data Visualization Palette
        ///
        ///Brown (1 is lightest, 10 is darkest)
        public static let brown10                    = rgb(76, 62, 20)
        
        /*
         * Gray
         */
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray1              = rgb(224, 224, 224)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray2              = rgb(204, 204, 204)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray3              = rgb(184, 184, 184)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray4              = rgb(163, 163, 163)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray5              = rgb(143, 143, 143)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray6              = rgb(122, 122, 122)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray7              = rgb(102, 102, 102)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray8              = rgb(77, 77, 77)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray9              = rgb(61, 61, 61)
        ///Data Visualization Palette
        ///
        ///Neutral Gray (1 is lightest, 10 is darkest)
        public static let neutralGray10             = rgb(41, 41, 41)
        
        /*
         * Salmon
         */
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon1                    = rgb(247, 219, 201)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon2                    = rgb(246, 212, 191)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon3                    = rgb(244, 204, 180)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon4                    = rgb(242, 191, 159)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon5                    = rgb(240, 179, 141)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon6                    = rgb(255, 160, 118)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon7                    = rgb(203, 140, 99)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon8                    = rgb(157, 108, 78)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon9                    = rgb(129, 89, 64)
        ///Data Visualization Palette
        ///
        ///Salmon (1 is lightest, 10 is darkest)
        public static let salmon10                   = rgb(101, 70, 50)

        ///Data Visualization Sets
        public enum DataVisualizationSets {
            ///Regular Data Visualization Set
            public static let regular = [UIColor.Predix.blue5, UIColor.Predix.orange5, UIColor.Predix.green5, UIColor.Predix.pink4, UIColor.Predix.brown6, UIColor.Predix.purple4, UIColor.Predix.yellow5, UIColor.Predix.red6, UIColor.Predix.neutralGray8]

            ///Light Data Visualization Set
            public static let light = [UIColor.Predix.blue3, UIColor.Predix.orange3, UIColor.Predix.green3, UIColor.Predix.pink2, UIColor.Predix.brown4, UIColor.Predix.purple3, UIColor.Predix.yellow3, UIColor.Predix.red3, UIColor.Predix.neutralGray5]

            ///Dark Data Visualization Set
            public static let dark = [UIColor.Predix.blue7, UIColor.Predix.orange7, UIColor.Predix.green7, UIColor.Predix.pink6, UIColor.Predix.brown7, UIColor.Predix.purple7, UIColor.Predix.yellow7, UIColor.Predix.red7, UIColor.Predix.neutralGray10]
        }
    }
}

extension UIColor {
    ///Returns the current set red for the color
    var redValue: CGFloat {
        return CIColor(color: self).red
    }
    ///Returns the current set green for the color
    var greenValue: CGFloat {
        return CIColor(color: self).green
    }
    ///Returns the current set blue for the color
    var blueValue: CGFloat {
        return CIColor(color: self).blue
    }
    ///Returns the current set alpha for the color
    var alphaValue: CGFloat {
        return CIColor(color: self).alpha
    }
}

