import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { provideFirebaseApp, initializeApp } from '@angular/fire/app';
import { getFirestore, provideFirestore } from '@angular/fire/firestore';
import { getStorage, provideStorage } from '@angular/fire/storage';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';

const config = {
  apiKey: "AIzaSyDliT9HSla5Plsw3iBr27bT1SvSJhVU6W0",
  authDomain: "pictordle-346508.firebaseapp.com",
  projectId: "pictordle-346508",
  storageBucket: "pictordle-346508.appspot.com",
  messagingSenderId: "395153571998",
  appId: "1:395153571998:web:b1bdfff382cd7424017b8f",
  measurementId: "G-0394Z5DYJX"
};

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    provideFirebaseApp(() => initializeApp(config)),
    provideFirestore(() => getFirestore()),
    provideStorage(() => getStorage()),
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
