// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DiaryController from "./diary_controller"
application.register("diary", DiaryController)

import CashioController from "./cashio_controller"
application.register("cashio", CashioController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import CarController from "./car_controller"
application.register("car", CarController)

import MeetingController from "./meeting_controller"
application.register("meeting", MeetingController)

import UserController from "./user_controller"
application.register("user", UserController)
