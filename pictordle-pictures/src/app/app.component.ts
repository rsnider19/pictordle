import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { DomSanitizer } from '@angular/platform-browser';
import { firstValueFrom, Observable } from 'rxjs';
import { Firestore, collectionData, collection, setDoc, doc } from '@angular/fire/firestore';
import { Storage, ref, uploadString, StringFormat } from '@angular/fire/storage';
import * as dayjs from 'dayjs'


interface Pictordle {
  id?: string,
  word: string,
}

interface ImageResp {
  images?: string[]
  version?: string;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
})
export class AppComponent implements OnInit {
  title = 'pictordle-pictures';
  wordImages = new Map<string, ImageResp>();

  constructor(
    public domSanitizer: DomSanitizer,
    private http: HttpClient,
    private readonly firestore: Firestore,
    private readonly storage: Storage,
  ) {

  }

  async ngOnInit(): Promise<void> {
    const resp = await firstValueFrom(this.http.get('../assets/images/_word_list.txt', { responseType: 'text' }));
    const words = resp.split('\n');

    words.slice(0, 49).forEach(async word => {
      const imageResp: ImageResp = await firstValueFrom(this.http.get(`../assets/images/${word}.json`));
      this.wordImages.set(word, imageResp);
    });
  }

  async imageClicked(word: string, base64: string) {
    const pictordlesCollection = collection(this.firestore, 'pictordles');
    const all = await firstValueFrom(
      collectionData(pictordlesCollection, { idField: 'id' }) as Observable<Pictordle[]>
    );

    const maxDate = Math.max(...all.map(p => dayjs(p.id).valueOf()));
    const newId = dayjs(maxDate).add(1, 'day').format('YYYY-MM-DD');
    const docRef = doc(pictordlesCollection, `${newId}`);
    setDoc(docRef, { word: word.toLowerCase() } as Pictordle);

    const imageRef = ref(this.storage, `pictordles/${word.toLowerCase()}.png`);
    uploadString(imageRef, base64, StringFormat.BASE64, {contentType: 'image/png'});

    this.remove(word);
  }

  remove(word: string) {
    this.wordImages.delete(word);
  }
}
