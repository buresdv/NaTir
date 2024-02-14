//
//  Get Stations.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import Foundation
import SwiftyXMLParser
import CoreLocation

// When I'm done with the parser, implement it here
/*func getStations() async -> [String]
{
    let soapPayload: String = """
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <Postaje xmlns="http://www.slo-zeleznice.si/">
      <username>zeljko</username>
      <password>joksimovic</password>
    </Postaje>
  </soap:Body>
</soap:Envelope>
"""
    
    let response: Data = try! await sendSoapRequest(action: .listAllStations, payloadBody: soapPayload)
    
    return String(data: response, encoding: .utf8)!
}
*/

func getStations() async -> [Station]
{
    let rawResponse: String = """
<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><PostajeResponse xmlns=\"http://www.slo-zeleznice.si/\"><PostajeResult><postaje xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"\"><postaja><st>44704</st><naziv>Anhovo</naziv><Geo_sirina>46.06311388</Geo_sirina><Geo_dolzina>13.62590277</Geo_dolzina></postaja><postaja><st>43856</st><naziv>Atomske Toplice hotel</naziv><Geo_sirina>46.15815000</Geo_sirina><Geo_dolzina>15.60853888</Geo_dolzina></postaja><postaja><st>44706</st><naziv>Avče</naziv><Geo_sirina>46.10811944</Geo_sirina><Geo_dolzina>13.68433611</Geo_dolzina></postaja><postaja><st>42510</st><naziv>Birčna vas</naziv><Geo_sirina>45.75782777</Geo_sirina><Geo_dolzina>15.14759444</Geo_dolzina></postaja><postaja><st>43403</st><naziv>Bistrica ob Dravi</naziv><Geo_sirina>46.55758888</Geo_sirina><Geo_dolzina>15.55424444</Geo_dolzina></postaja><postaja><st>42006</st><naziv>Blanca</naziv><Geo_sirina>45.98971944</Geo_sirina><Geo_dolzina>15.39579444</Geo_dolzina></postaja><postaja><st>44716</st><naziv>Bled Jezero</naziv><Geo_sirina>46.36818611</Geo_sirina><Geo_dolzina>14.08256944</Geo_dolzina></postaja><postaja><st>44715</st><naziv>Bohinjska Bela</naziv><Geo_sirina>46.33840555</Geo_sirina><Geo_dolzina>14.06025277</Geo_dolzina></postaja><postaja><st>44712</st><naziv>Bohinjska Bistrica</naziv><Geo_sirina>46.27435277</Geo_sirina><Geo_dolzina>13.95885000</Geo_dolzina></postaja><postaja><st>44004</st><naziv>Borovnica</naziv><Geo_sirina>45.92138888</Geo_sirina><Geo_dolzina>14.36772222</Geo_dolzina></postaja><postaja><st>42901</st><naziv>Boštanj</naziv><Geo_sirina>46.00739444</Geo_sirina><Geo_dolzina>15.28987500</Geo_dolzina></postaja><postaja><st>44504</st><naziv>Branik</naziv><Geo_sirina>45.85601944</Geo_sirina><Geo_dolzina>13.78427777</Geo_dolzina></postaja><postaja><st>42101</st><naziv>Breg</naziv><Geo_sirina>46.04180000</Geo_sirina><Geo_dolzina>15.23556944</Geo_dolzina></postaja><postaja><st>42005</st><naziv>Brestanica</naziv><Geo_sirina>45.98777500</Geo_sirina><Geo_dolzina>15.46949166</Geo_dolzina></postaja><postaja><st>44001</st><naziv>Brezovica</naziv><Geo_sirina>46.02151388</Geo_sirina><Geo_dolzina>14.42640277</Geo_dolzina></postaja><postaja><st>42002</st><naziv>Brežice</naziv><Geo_sirina>45.92372222</Geo_sirina><Geo_dolzina>15.58983611</Geo_dolzina></postaja><postaja><st>77425</st><naziv>Buzet (HR)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>43100</st><naziv>Celje</naziv><Geo_sirina>46.22852500</Geo_sirina><Geo_dolzina>15.26788055</Geo_dolzina></postaja><postaja><st>43911</st><naziv>Celje Lava</naziv><Geo_sirina>46.23656388</Geo_sirina><Geo_dolzina>15.25959444</Geo_dolzina></postaja><postaja><st>43452</st><naziv>Cirknica</naziv><Geo_sirina>46.66122500</Geo_sirina><Geo_dolzina>15.65912222</Geo_dolzina></postaja><postaja><st>43351</st><naziv>Cirkovce</naziv><Geo_sirina>46.40089722</Geo_sirina><Geo_dolzina>15.72437500</Geo_dolzina></postaja><postaja><st>74860</st><naziv>Čakovec (HR)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>42505</st><naziv>Črnomelj</naziv><Geo_sirina>45.57983611</Geo_sirina><Geo_dolzina>15.19115000</Geo_dolzina></postaja><postaja><st>44356</st><naziv>Črnotiče</naziv><Geo_sirina>45.55213888</Geo_sirina><Geo_dolzina>13.89161388</Geo_dolzina></postaja><postaja><st>42859</st><naziv>Čušperk</naziv><Geo_sirina>45.89121388</Geo_sirina><Geo_dolzina>14.69763055</Geo_dolzina></postaja><postaja><st>44200</st><naziv>Divača</naziv><Geo_sirina>45.68181666</Geo_sirina><Geo_dolzina>13.96476944</Geo_dolzina></postaja><postaja><st>99996</st><naziv>Divača(Škocjanske jame)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>42001</st><naziv>Dobova</naziv><Geo_sirina>45.89839166</Geo_sirina><Geo_dolzina>15.65468333</Geo_dolzina></postaja><postaja><st>43805</st><naziv>Dobovec</naziv><Geo_sirina>46.22074166</Geo_sirina><Geo_dolzina>15.75161666</Geo_dolzina></postaja><postaja><st>42503</st><naziv>Dobravice</naziv><Geo_sirina>45.63229722</Geo_sirina><Geo_dolzina>15.26974722</Geo_dolzina></postaja><postaja><st>42851</st><naziv>Dobrepolje</naziv><Geo_sirina>45.85836388</Geo_sirina><Geo_dolzina>14.68145277</Geo_dolzina></postaja><postaja><st>43506</st><naziv>Dobrije</naziv><Geo_sirina>46.55153333</Geo_sirina><Geo_dolzina>14.99079722</Geo_dolzina></postaja><postaja><st>43202</st><naziv>Dolga Gora</naziv><Geo_sirina>46.27751388</Geo_sirina><Geo_dolzina>15.49818333</Geo_dolzina></postaja><postaja><st>42352</st><naziv>Domžale</naziv><Geo_sirina>46.13927500</Geo_sirina><Geo_dolzina>14.59249444</Geo_dolzina></postaja><postaja><st>44506</st><naziv>Dornberk</naziv><Geo_sirina>45.88587777</Geo_sirina><Geo_dolzina>13.73386111</Geo_dolzina></postaja><postaja><st>43500</st><naziv>Dravograd</naziv><Geo_sirina>46.58710277</Geo_sirina><Geo_dolzina>15.02679722</Geo_dolzina></postaja><postaja><st>42363</st><naziv>Duplica-Bakovnik</naziv><Geo_sirina>46.20603611</Geo_sirina><Geo_dolzina>14.59435000</Geo_dolzina></postaja><postaja><st>44800</st><naziv>Dutovlje</naziv><Geo_sirina>45.76478888</Geo_sirina><Geo_dolzina>13.82634722</Geo_dolzina></postaja><postaja><st>74606</st><naziv>Đurmanec (HR)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>43405</st><naziv>Fala</naziv><Geo_sirina>46.54810833</Geo_sirina><Geo_dolzina>15.45150277</Geo_dolzina></postaja><postaja><st>43912</st><naziv>Florjan</naziv><Geo_sirina>46.38116111</Geo_sirina><Geo_dolzina>15.03006666</Geo_dolzina></postaja><postaja><st>43653</st><naziv>Frankovci</naziv><Geo_sirina>46.39489722</Geo_sirina><Geo_dolzina>16.19528611</Geo_dolzina></postaja><postaja><st>42704</st><naziv>Gaber</naziv><Geo_sirina>45.94059444</Geo_sirina><Geo_dolzina>14.90927777</Geo_dolzina></postaja><postaja><st>42311</st><naziv>Globoko</naziv><Geo_sirina>46.32321388</Geo_sirina><Geo_dolzina>14.20844444</Geo_dolzina></postaja><postaja><st>42908</st><naziv>Gomila</naziv><Geo_sirina>45.93474166</Geo_sirina><Geo_dolzina>15.04493611</Geo_dolzina></postaja><postaja><st>44102</st><naziv>Gornje Ležeče</naziv><Geo_sirina>45.66636944</Geo_sirina><Geo_dolzina>14.07200277</Geo_dolzina></postaja><postaja><st>43775</st><naziv>Gornji Petrovci</naziv><Geo_sirina>46.80072777</Geo_sirina><Geo_dolzina>16.21832777</Geo_dolzina></postaja><postaja><st>42504</st><naziv>Gradac</naziv><Geo_sirina>45.61435277</Geo_sirina><Geo_dolzina>15.24145833</Geo_dolzina></postaja><postaja><st>44709</st><naziv>Grahovo</naziv><Geo_sirina>46.15156944</Geo_sirina><Geo_dolzina>13.85696666</Geo_dolzina></postaja><postaja><st>43702</st><naziv>Grlava</naziv><Geo_sirina>46.55707500</Geo_sirina><Geo_dolzina>16.17402222</Geo_dolzina></postaja><postaja><st>43200</st><naziv>Grobelno</naziv><Geo_sirina>46.21299722</Geo_sirina><Geo_dolzina>15.43974166</Geo_dolzina></postaja><postaja><st>42800</st><naziv>Grosuplje</naziv><Geo_sirina>45.95606666</Geo_sirina><Geo_dolzina>14.65251111</Geo_dolzina></postaja><postaja><st>43354</st><naziv>Hajdina</naziv><Geo_sirina>46.40311388</Geo_sirina><Geo_dolzina>15.85518611</Geo_dolzina></postaja><postaja><st>43303</st><naziv>Hoče</naziv><Geo_sirina>46.50098333</Geo_sirina><Geo_dolzina>15.66306944</Geo_dolzina></postaja><postaja><st>43777</st><naziv>Hodoš</naziv><Geo_sirina>46.82034722</Geo_sirina><Geo_dolzina>16.32940277</Geo_dolzina></postaja><postaja><st>43503</st><naziv>Holmec</naziv><Geo_sirina>46.56637777</Geo_sirina><Geo_dolzina>14.84136944</Geo_dolzina></postaja><postaja><st>42361</st><naziv>Homec pri Kamniku</naziv><Geo_sirina>46.17986388</Geo_sirina><Geo_dolzina>14.59069166</Geo_dolzina></postaja><postaja><st>42201</st><naziv>Hrastnik</naziv><Geo_sirina>46.12268888</Geo_sirina><Geo_dolzina>15.09358055</Geo_dolzina></postaja><postaja><st>44357</st><naziv>Hrastovlje</naziv><Geo_sirina>45.50113055</Geo_sirina><Geo_dolzina>13.90942777</Geo_dolzina></postaja><postaja><st>44202</st><naziv>Hrpelje-Kozina</naziv><Geo_sirina>45.60376666</Geo_sirina><Geo_dolzina>13.93485555</Geo_dolzina></postaja><postaja><st>44710</st><naziv>Hudajužna</naziv><Geo_sirina>46.17980833</Geo_sirina><Geo_dolzina>13.91960833</Geo_dolzina></postaja><postaja><st>42603</st><naziv>Hudo</naziv><Geo_sirina>45.83380000</Geo_sirina><Geo_dolzina>15.13620277</Geo_dolzina></postaja><postaja><st>44903</st><naziv>Ilirska Bistrica</naziv><Geo_sirina>45.56938333</Geo_sirina><Geo_dolzina>14.23605555</Geo_dolzina></postaja><postaja><st>43854</st><naziv>Imeno</naziv><Geo_sirina>46.12697777</Geo_sirina><Geo_dolzina>15.60086111</Geo_dolzina></postaja><postaja><st>42707</st><naziv>Ivančna Gorica</naziv><Geo_sirina>45.93816111</Geo_sirina><Geo_dolzina>14.80307222</Geo_dolzina></postaja><postaja><st>43603</st><naziv>Ivanjkovci</naziv><Geo_sirina>46.45860000</Geo_sirina><Geo_dolzina>16.15649722</Geo_dolzina></postaja><postaja><st>42353</st><naziv>Jarše-Mengeš</naziv><Geo_sirina>46.16569166</Geo_sirina><Geo_dolzina>14.59395277</Geo_dolzina></postaja><postaja><st>42902</st><naziv>Jelovec</naziv><Geo_sirina>45.98932222</Geo_sirina><Geo_dolzina>15.23979722</Geo_dolzina></postaja><postaja><st>42400</st><naziv>Jesenice</naziv><Geo_sirina>46.43639722</Geo_sirina><Geo_dolzina>14.05484166</Geo_dolzina></postaja><postaja><st>42209</st><naziv>Jevnica</naziv><Geo_sirina>46.08402500</Geo_sirina><Geo_dolzina>14.73675833</Geo_dolzina></postaja><postaja><st>42354</st><naziv>Kamnik</naziv><Geo_sirina>46.22070277</Geo_sirina><Geo_dolzina>14.60375000</Geo_dolzina></postaja><postaja><st>42356</st><naziv>Kamnik Graben</naziv><Geo_sirina>46.22875833</Geo_sirina><Geo_dolzina>14.60950277</Geo_dolzina></postaja><postaja><st>42355</st><naziv>Kamnik mesto</naziv><Geo_sirina>46.22479166</Geo_sirina><Geo_dolzina>14.60916111</Geo_dolzina></postaja><postaja><st>44705</st><naziv>Kanal</naziv><Geo_sirina>46.08376944</Geo_sirina><Geo_dolzina>13.63181111</Geo_dolzina></postaja><postaja><st>43353</st><naziv>Kidričevo</naziv><Geo_sirina>46.40088611</Geo_sirina><Geo_dolzina>15.80045833</Geo_dolzina></postaja><postaja><st>44902</st><naziv>Kilovče</naziv><Geo_sirina>45.61553611</Geo_sirina><Geo_dolzina>14.18594722</Geo_dolzina></postaja><postaja><st>42856</st><naziv>Kočevje</naziv><Geo_sirina>45.64626944</Geo_sirina><Geo_dolzina>14.85682500</Geo_dolzina></postaja><postaja><st>44719</st><naziv>Kočna</naziv><Geo_sirina>46.42385277</Geo_sirina><Geo_dolzina>14.07866111</Geo_dolzina></postaja><postaja><st>44352</st><naziv>Koper</naziv><Geo_sirina>45.53932500</Geo_sirina><Geo_dolzina>13.73835000</Geo_dolzina></postaja><postaja><st>44502</st><naziv>Kopriva</naziv><Geo_sirina>45.78485000</Geo_sirina><Geo_dolzina>13.83182777</Geo_dolzina></postaja><postaja><st>44101</st><naziv>Košana</naziv><Geo_sirina>45.67060000</Geo_sirina><Geo_dolzina>14.10573888</Geo_dolzina></postaja><postaja><st>42307</st><naziv>Kranj</naziv><Geo_sirina>46.23900277</Geo_sirina><Geo_dolzina>14.34844166</Geo_dolzina></postaja><postaja><st>44501</st><naziv>Kreplje</naziv><Geo_sirina>45.74207777</Geo_sirina><Geo_dolzina>13.82742777</Geo_dolzina></postaja><postaja><st>42208</st><naziv>Kresnice</naziv><Geo_sirina>46.10300000</Geo_sirina><Geo_dolzina>14.79116666</Geo_dolzina></postaja><postaja><st>42004</st><naziv>Krško</naziv><Geo_sirina>45.95625833</Geo_sirina><Geo_dolzina>15.49355000</Geo_dolzina></postaja><postaja><st>43002</st><naziv>Laško</naziv><Geo_sirina>46.15453611</Geo_sirina><Geo_dolzina>15.23225833</Geo_dolzina></postaja><postaja><st>42803</st><naziv>Lavrica</naziv><Geo_sirina>45.99906666</Geo_sirina><Geo_dolzina>14.55441944</Geo_dolzina></postaja><postaja><st>42210</st><naziv>Laze</naziv><Geo_sirina>46.08805000</Geo_sirina><Geo_dolzina>14.68766944</Geo_dolzina></postaja><postaja><st>42313</st><naziv>Lesce-Bled</naziv><Geo_sirina>46.36043333</Geo_sirina><Geo_dolzina>14.15809166</Geo_dolzina></postaja><postaja><st>42003</st><naziv>Libna</naziv><Geo_sirina>45.94550277</Geo_sirina><Geo_dolzina>15.54035833</Geo_dolzina></postaja><postaja><st>43402</st><naziv>Limbuš</naziv><Geo_sirina>46.55891388</Geo_sirina><Geo_dolzina>15.58295000</Geo_dolzina></postaja><postaja><st>43703</st><naziv>Lipovci</naziv><Geo_sirina>46.62373611</Geo_sirina><Geo_dolzina>16.21151388</Geo_dolzina></postaja><postaja><st>42207</st><naziv>Litija</naziv><Geo_sirina>46.05794722</Geo_sirina><Geo_dolzina>14.82524166</Geo_dolzina></postaja><postaja><st>99993</st><naziv>Litija(Dom-Tisje)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>99991</st><naziv>Litija(Gabrovka)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>99992</st><naziv>Litija(Slivna)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>99994</st><naziv>Litija(Šmartno-Cerkovnik)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>99995</st><naziv>Litija(Zavrstnik pri Tatjani)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>42316</st><naziv>Litostroj</naziv><Geo_sirina>46.07736388</Geo_sirina><Geo_dolzina>14.48971944</Geo_dolzina></postaja><postaja><st>42300</st><naziv>Ljubljana</naziv><Geo_sirina>46.05810833</Geo_sirina><Geo_dolzina>14.51027777</Geo_dolzina></postaja><postaja><st>42357</st><naziv>Ljubljana Brinje</naziv><Geo_sirina>46.07625000</Geo_sirina><Geo_dolzina>14.50301111</Geo_dolzina></postaja><postaja><st>42351</st><naziv>Ljubljana Črnuče</naziv><Geo_sirina>46.10117500</Geo_sirina><Geo_dolzina>14.52625277</Geo_dolzina></postaja><postaja><st>44012</st><naziv>Ljubljana Dolgi most</naziv><Geo_sirina>46.03772222</Geo_sirina><Geo_dolzina>14.46479166</Geo_dolzina></postaja><postaja><st>42365</st><naziv>Ljubljana Ježica</naziv><Geo_sirina>46.08985555</Geo_sirina><Geo_dolzina>14.50739166</Geo_dolzina></postaja><postaja><st>42212</st><naziv>Ljubljana Polje</naziv><Geo_sirina>46.05883333</Geo_sirina><Geo_dolzina>14.58470833</Geo_dolzina></postaja><postaja><st>42804</st><naziv>Ljubljana Rakovnik</naziv><Geo_sirina>46.03709444</Geo_sirina><Geo_dolzina>14.51898333</Geo_dolzina></postaja><postaja><st>42317</st><naziv>Ljubljana Stegne</naziv><Geo_sirina>46.08680555</Geo_sirina><Geo_dolzina>14.47997777</Geo_dolzina></postaja><postaja><st>44011</st><naziv>Ljubljana Tivoli</naziv><Geo_sirina>46.05020833</Geo_sirina><Geo_dolzina>14.49403611</Geo_dolzina></postaja><postaja><st>42302</st><naziv>Ljubljana Vižmarje</naziv><Geo_sirina>46.10039722</Geo_sirina><Geo_dolzina>14.46446944</Geo_dolzina></postaja><postaja><st>42805</st><naziv>Ljubljana Vodmat</naziv><Geo_sirina>46.05579444</Geo_sirina><Geo_dolzina>14.52913055</Geo_dolzina></postaja><postaja><st>42222</st><naziv>Ljubljana Zalog</naziv><Geo_sirina>46.05975555</Geo_sirina><Geo_dolzina>14.61536111</Geo_dolzina></postaja><postaja><st>43700</st><naziv>Ljutomer</naziv><Geo_sirina>46.52877500</Geo_sirina><Geo_dolzina>16.18928611</Geo_dolzina></postaja><postaja><st>43605</st><naziv>Ljutomer mesto</naziv><Geo_sirina>46.52097222</Geo_sirina><Geo_dolzina>16.19960555</Geo_dolzina></postaja><postaja><st>44006</st><naziv>Logatec</naziv><Geo_sirina>45.91775277</Geo_sirina><Geo_dolzina>14.23546944</Geo_dolzina></postaja><postaja><st>42102</st><naziv>Loka</naziv><Geo_sirina>46.05358611</Geo_sirina><Geo_dolzina>15.20567500</Geo_dolzina></postaja><postaja><st>43774</st><naziv>Mačkovci</naziv><Geo_sirina>46.78331388</Geo_sirina><Geo_dolzina>16.16471666</Geo_dolzina></postaja><postaja><st>43400</st><naziv>Maribor</naziv><Geo_sirina>46.56189444</Geo_sirina><Geo_dolzina>15.65749722</Geo_dolzina></postaja><postaja><st>43420</st><naziv>Maribor Sokolska</naziv><Geo_sirina>46.55642500</Geo_sirina><Geo_dolzina>15.62487500</Geo_dolzina></postaja><postaja><st>43401</st><naziv>Maribor Studenci</naziv><Geo_sirina>46.55441388</Geo_sirina><Geo_dolzina>15.63528611</Geo_dolzina></postaja><postaja><st>43413</st><naziv>Maribor Tabor</naziv><Geo_sirina>46.55178055</Geo_sirina><Geo_dolzina>15.64546666</Geo_dolzina></postaja><postaja><st>43304</st><naziv>Maribor Tezno</naziv><Geo_sirina>46.53905833</Geo_sirina><Geo_dolzina>15.65128611</Geo_dolzina></postaja><postaja><st>43414</st><naziv>Marles</naziv><Geo_sirina>46.55886666</Geo_sirina><Geo_dolzina>15.59720555</Geo_dolzina></postaja><postaja><st>42303</st><naziv>Medno</naziv><Geo_sirina>46.12214444</Geo_sirina><Geo_dolzina>14.43905277</Geo_dolzina></postaja><postaja><st>42304</st><naziv>Medvode</naziv><Geo_sirina>46.13806111</Geo_sirina><Geo_dolzina>14.41228888</Geo_dolzina></postaja><postaja><st>43604</st><naziv>Mekotnjak</naziv><Geo_sirina>46.50098888</Geo_sirina><Geo_dolzina>16.15521666</Geo_dolzina></postaja><postaja><st>43801</st><naziv>Mestinje</naziv><Geo_sirina>46.23505000</Geo_sirina><Geo_dolzina>15.56426666</Geo_dolzina></postaja><postaja><st>42502</st><naziv>Metlika</naziv><Geo_sirina>45.64255833</Geo_sirina><Geo_dolzina>15.32285833</Geo_dolzina></postaja><postaja><st>42907</st><naziv>Mirna</naziv><Geo_sirina>45.94938333</Geo_sirina><Geo_dolzina>15.06241388</Geo_dolzina></postaja><postaja><st>42601</st><naziv>Mirna Peč</naziv><Geo_sirina>45.86661111</Geo_sirina><Geo_dolzina>15.09140555</Geo_dolzina></postaja><postaja><st>42711</st><naziv>Mlačevo</naziv><Geo_sirina>45.94025000</Geo_sirina><Geo_dolzina>14.68511388</Geo_dolzina></postaja><postaja><st>42905</st><naziv>Mokronog</naziv><Geo_sirina>45.95785277</Geo_sirina><Geo_dolzina>15.12159166</Geo_dolzina></postaja><postaja><st>44707</st><naziv>Most na Soči</naziv><Geo_sirina>46.14657500</Geo_sirina><Geo_dolzina>13.75952500</Geo_dolzina></postaja><postaja><st>43356</st><naziv>Moškanjci</naziv><Geo_sirina>46.42316944</Geo_sirina><Geo_dolzina>15.98362222</Geo_dolzina></postaja><postaja><st>43704</st><naziv>Murska Sobota</naziv><Geo_sirina>46.65939166</Geo_sirina><Geo_dolzina>16.17159722</Geo_dolzina></postaja><postaja><st>44901</st><naziv>Narin</naziv><Geo_sirina>45.64127777</Geo_sirina><Geo_dolzina>14.19804166</Geo_dolzina></postaja><postaja><st>44713</st><naziv>Nomenj</naziv><Geo_sirina>46.28918888</Geo_sirina><Geo_dolzina>14.00254722</Geo_dolzina></postaja><postaja><st>44002</st><naziv>Notranje Gorice</naziv><Geo_sirina>45.98758888</Geo_sirina><Geo_dolzina>14.40243611</Geo_dolzina></postaja><postaja><st>44700</st><naziv>Nova Gorica</naziv><Geo_sirina>45.95512222</Geo_sirina><Geo_dolzina>13.63525833</Geo_dolzina></postaja><postaja><st>42600</st><naziv>Novo mesto</naziv><Geo_sirina>45.81097222</Geo_sirina><Geo_dolzina>15.15589722</Geo_dolzina></postaja><postaja><st>42512</st><naziv>Novo mesto Center</naziv><Geo_sirina>45.80446388</Geo_sirina><Geo_dolzina>15.16213055</Geo_dolzina></postaja><postaja><st>42511</st><naziv>Novo mesto Kandija</naziv><Geo_sirina>45.79977777</Geo_sirina><Geo_dolzina>15.16079166</Geo_dolzina></postaja><postaja><st>42514</st><naziv>Novo mesto Šmihel</naziv><Geo_sirina>45.79658333</Geo_sirina><Geo_dolzina>15.16105555</Geo_dolzina></postaja><postaja><st>43651</st><naziv>Obrež</naziv><Geo_sirina>46.39089722</Geo_sirina><Geo_dolzina>16.22572222</Geo_dolzina></postaja><postaja><st>44601</st><naziv>Okroglica</naziv><Geo_sirina>45.89923333</Geo_sirina><Geo_dolzina>13.69031944</Geo_dolzina></postaja><postaja><st>03466</st><naziv>Opčine/Villa Opicina (I)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>43302</st><naziv>Orehova vas</naziv><Geo_sirina>46.47308888</Geo_sirina><Geo_dolzina>15.66355277</Geo_dolzina></postaja><postaja><st>05074</st><naziv>Oriszentpeter (H)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>43600</st><naziv>Ormož</naziv><Geo_sirina>46.40322777</Geo_sirina><Geo_dolzina>16.15620000</Geo_dolzina></postaja><postaja><st>42853</st><naziv>Ortnek</naziv><Geo_sirina>45.79014166</Geo_sirina><Geo_dolzina>14.68013055</Geo_dolzina></postaja><postaja><st>43357</st><naziv>Osluševci</naziv><Geo_sirina>46.41938888</Geo_sirina><Geo_dolzina>16.04798055</Geo_dolzina></postaja><postaja><st>43205</st><naziv>Ostrožno</naziv><Geo_sirina>46.26401111</Geo_sirina><Geo_dolzina>15.47288611</Geo_dolzina></postaja><postaja><st>42310</st><naziv>Otoče</naziv><Geo_sirina>46.31110000</Geo_sirina><Geo_dolzina>14.23265833</Geo_dolzina></postaja><postaja><st>42506</st><naziv>Otovec</naziv><Geo_sirina>45.59886666</Geo_sirina><Geo_dolzina>15.16174166</Geo_dolzina></postaja><postaja><st>43407</st><naziv>Ožbalt</naziv><Geo_sirina>46.57491388</Geo_sirina><Geo_dolzina>15.40646666</Geo_dolzina></postaja><postaja><st>43906</st><naziv>Paška vas</naziv><Geo_sirina>46.34150833</Geo_sirina><Geo_dolzina>15.01978333</Geo_dolzina></postaja><postaja><st>43602</st><naziv>Pavlovci</naziv><Geo_sirina>46.42643333</Geo_sirina><Geo_dolzina>16.17948888</Geo_dolzina></postaja><postaja><st>43451</st><naziv>Pesnica</naziv><Geo_sirina>46.60985277</Geo_sirina><Geo_dolzina>15.68030555</Geo_dolzina></postaja><postaja><st>43901</st><naziv>Petrovče</naziv><Geo_sirina>46.24595277</Geo_sirina><Geo_dolzina>15.18968611</Geo_dolzina></postaja><postaja><st>42904</st><naziv>Pijavice</naziv><Geo_sirina>45.96829444</Geo_sirina><Geo_dolzina>15.16329444</Geo_dolzina></postaja><postaja><st>44100</st><naziv>Pivka</naziv><Geo_sirina>45.67516666</Geo_sirina><Geo_dolzina>14.19148333</Geo_dolzina></postaja><postaja><st>44007</st><naziv>Planina</naziv><Geo_sirina>45.86163611</Geo_sirina><Geo_dolzina>14.27482777</Geo_dolzina></postaja><postaja><st>44703</st><naziv>Plave</naziv><Geo_sirina>46.04616388</Geo_sirina><Geo_dolzina>13.58996944</Geo_dolzina></postaja><postaja><st>03825</st><naziv>Pliberk/Bleiburg (A)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>44711</st><naziv>Podbrdo</naziv><Geo_sirina>46.20928055</Geo_sirina><Geo_dolzina>13.96676944</Geo_dolzina></postaja><postaja><st>43853</st><naziv>Podčetrtek</naziv><Geo_sirina>46.15036666</Geo_sirina><Geo_dolzina>15.59956666</Geo_dolzina></postaja><postaja><st>43855</st><naziv>Podčetrtek Toplice</naziv><Geo_sirina>46.16587222</Geo_sirina><Geo_dolzina>15.60478888</Geo_dolzina></postaja><postaja><st>44301</st><naziv>Podgorje</naziv><Geo_sirina>45.53438055</Geo_sirina><Geo_dolzina>13.94301388</Geo_dolzina></postaja><postaja><st>44717</st><naziv>Podhom</naziv><Geo_sirina>46.38756111</Geo_sirina><Geo_dolzina>14.09418333</Geo_dolzina></postaja><postaja><st>43505</st><naziv>Podklanc</naziv><Geo_sirina>46.57411944</Geo_sirina><Geo_dolzina>15.00577222</Geo_dolzina></postaja><postaja><st>44708</st><naziv>Podmelec</naziv><Geo_sirina>46.15949722</Geo_sirina><Geo_dolzina>13.81390555</Geo_dolzina></postaja><postaja><st>42309</st><naziv>Podnart</naziv><Geo_sirina>46.29386944</Geo_sirina><Geo_dolzina>14.25827222</Geo_dolzina></postaja><postaja><st>43802</st><naziv>Podplat</naziv><Geo_sirina>46.24415555</Geo_sirina><Geo_dolzina>15.57311944</Geo_dolzina></postaja><postaja><st>02143</st><naziv>Podrožca/Rosenbach (A)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>43408</st><naziv>Podvelka</naziv><Geo_sirina>46.59000277</Geo_sirina><Geo_dolzina>15.32941666</Geo_dolzina></postaja><postaja><st>43203</st><naziv>Poljčane</naziv><Geo_sirina>46.31350833</Geo_sirina><Geo_dolzina>15.57680277</Geo_dolzina></postaja><postaja><st>43904</st><naziv>Polzela</naziv><Geo_sirina>46.28269722</Geo_sirina><Geo_dolzina>15.06604444</Geo_dolzina></postaja><postaja><st>42708</st><naziv>Polževo</naziv><Geo_sirina>45.94071388</Geo_sirina><Geo_dolzina>14.77905555</Geo_dolzina></postaja><postaja><st>43201</st><naziv>Ponikva</naziv><Geo_sirina>46.24786388</Geo_sirina><Geo_dolzina>15.43077777</Geo_dolzina></postaja><postaja><st>42602</st><naziv>Ponikve na Dolenjskem</naziv><Geo_sirina>45.89769444</Geo_sirina><Geo_dolzina>15.04266388</Geo_dolzina></postaja><postaja><st>44009</st><naziv>Postojna</naziv><Geo_sirina>45.77306666</Geo_sirina><Geo_dolzina>14.22131666</Geo_dolzina></postaja><postaja><st>44251</st><naziv>Povir</naziv><Geo_sirina>45.69943055</Geo_sirina><Geo_dolzina>13.93055833</Geo_dolzina></postaja><postaja><st>43300</st><naziv>Pragersko</naziv><Geo_sirina>46.39546111</Geo_sirina><Geo_dolzina>15.66195000</Geo_dolzina></postaja><postaja><st>44003</st><naziv>Preserje</naziv><Geo_sirina>45.96565000</Geo_sirina><Geo_dolzina>14.39636666</Geo_dolzina></postaja><postaja><st>44010</st><naziv>Prestranek</naziv><Geo_sirina>45.72861388</Geo_sirina><Geo_dolzina>14.18531388</Geo_dolzina></postaja><postaja><st>44300</st><naziv>Prešnica</naziv><Geo_sirina>45.57048333</Geo_sirina><Geo_dolzina>13.94099722</Geo_dolzina></postaja><postaja><st>43502</st><naziv>Prevalje</naziv><Geo_sirina>46.54989166</Geo_sirina><Geo_dolzina>14.92181111</Geo_dolzina></postaja><postaja><st>43851</st><naziv>Pristava</naziv><Geo_sirina>46.19875000</Geo_sirina><Geo_dolzina>15.58181944</Geo_dolzina></postaja><postaja><st>44600</st><naziv>Prvačina</naziv><Geo_sirina>45.88769166</Geo_sirina><Geo_dolzina>13.72275555</Geo_dolzina></postaja><postaja><st>43355</st><naziv>Ptuj</naziv><Geo_sirina>46.42238888</Geo_sirina><Geo_dolzina>15.87872222</Geo_dolzina></postaja><postaja><st>43771</st><naziv>Puconci</naziv><Geo_sirina>46.70333055</Geo_sirina><Geo_dolzina>16.15368055</Geo_dolzina></postaja><postaja><st>43601</st><naziv>Pušenci</naziv><Geo_sirina>46.40972777</Geo_sirina><Geo_dolzina>16.17632777</Geo_dolzina></postaja><postaja><st>43301</st><naziv>Rače</naziv><Geo_sirina>46.45349722</Geo_sirina><Geo_dolzina>15.66400277</Geo_dolzina></postaja><postaja><st>42103</st><naziv>Radeče</naziv><Geo_sirina>46.06443055</Geo_sirina><Geo_dolzina>15.19220555</Geo_dolzina></postaja><postaja><st>42705</st><naziv>Radohova vas</naziv><Geo_sirina>45.94342777</Geo_sirina><Geo_dolzina>14.87303055</Geo_dolzina></postaja><postaja><st>42312</st><naziv>Radovljica</naziv><Geo_sirina>46.34055833</Geo_sirina><Geo_dolzina>14.17382500</Geo_dolzina></postaja><postaja><st>44008</st><naziv>Rakek</naziv><Geo_sirina>45.81517777</Geo_sirina><Geo_dolzina>14.31281388</Geo_dolzina></postaja><postaja><st>44303</st><naziv>Rakitovec</naziv><Geo_sirina>45.46595555</Geo_sirina><Geo_dolzina>13.95549722</Geo_dolzina></postaja><postaja><st>43501</st><naziv>Ravne na Koroškem</naziv><Geo_sirina>46.54700000</Geo_sirina><Geo_dolzina>14.96336944</Geo_dolzina></postaja><postaja><st>42305</st><naziv>Reteče</naziv><Geo_sirina>46.15663333</Geo_sirina><Geo_dolzina>14.37120555</Geo_dolzina></postaja><postaja><st>42854</st><naziv>Ribnica</naziv><Geo_sirina>45.74330555</Geo_sirina><Geo_dolzina>14.73037500</Geo_dolzina></postaja><postaja><st>43001</st><naziv>Rimske Toplice</naziv><Geo_sirina>46.12351944</Geo_sirina><Geo_dolzina>15.20292222</Geo_dolzina></postaja><postaja><st>43808</st><naziv>Rjavica</naziv><Geo_sirina>46.21978611</Geo_sirina><Geo_dolzina>15.65228888</Geo_dolzina></postaja><postaja><st>42360</st><naziv>Rodica</naziv><Geo_sirina>46.14903055</Geo_sirina><Geo_dolzina>14.59242500</Geo_dolzina></postaja><postaja><st>44201</st><naziv>Rodik</naziv><Geo_sirina>45.62707500</Geo_sirina><Geo_dolzina>13.97533333</Geo_dolzina></postaja><postaja><st>43803</st><naziv>Rogaška Slatina</naziv><Geo_sirina>46.23184722</Geo_sirina><Geo_dolzina>15.63829722</Geo_dolzina></postaja><postaja><st>43804</st><naziv>Rogatec</naziv><Geo_sirina>46.22458611</Geo_sirina><Geo_dolzina>15.69792222</Geo_dolzina></postaja><postaja><st>42501</st><naziv>Rosalnice</naziv><Geo_sirina>45.64887500</Geo_sirina><Geo_dolzina>15.33626944</Geo_dolzina></postaja><postaja><st>42508</st><naziv>Rožni Dol</naziv><Geo_sirina>45.68185000</Geo_sirina><Geo_dolzina>15.14852222</Geo_dolzina></postaja><postaja><st>43404</st><naziv>Ruše</naziv><Geo_sirina>46.54079444</Geo_sirina><Geo_dolzina>15.50394722</Geo_dolzina></postaja><postaja><st>43415</st><naziv>Ruše tovarna</naziv><Geo_sirina>46.54496666</Geo_sirina><Geo_dolzina>15.51478333</Geo_dolzina></postaja><postaja><st>43406</st><naziv>Ruta</naziv><Geo_sirina>46.56310833</Geo_sirina><Geo_dolzina>15.43163055</Geo_dolzina></postaja><postaja><st>42206</st><naziv>Sava</naziv><Geo_sirina>46.08901944</Geo_sirina><Geo_dolzina>14.89902500</Geo_dolzina></postaja><postaja><st>74102</st><naziv>Savski Marof (HR)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>42507</st><naziv>Semič</naziv><Geo_sirina>45.64316944</Geo_sirina><Geo_dolzina>15.16172222</Geo_dolzina></postaja><postaja><st>42100</st><naziv>Sevnica</naziv><Geo_sirina>46.00967777</Geo_sirina><Geo_dolzina>15.30134166</Geo_dolzina></postaja><postaja><st>44500</st><naziv>Sežana</naziv><Geo_sirina>45.70424166</Geo_sirina><Geo_dolzina>13.86353055</Geo_dolzina></postaja><postaja><st>43204</st><naziv>Slovenska Bistrica</naziv><Geo_sirina>46.36333611</Geo_sirina><Geo_dolzina>15.59808055</Geo_dolzina></postaja><postaja><st>42315</st><naziv>Slovenski Javornik</naziv><Geo_sirina>46.42714166</Geo_sirina><Geo_dolzina>14.08813888</Geo_dolzina></postaja><postaja><st>43852</st><naziv>Sodna vas</naziv><Geo_sirina>46.17592500</Geo_sirina><Geo_dolzina>15.60185277</Geo_dolzina></postaja><postaja><st>44701</st><naziv>Solkan</naziv><Geo_sirina>45.97260000</Geo_sirina><Geo_dolzina>13.64631666</Geo_dolzina></postaja><postaja><st>42857</st><naziv>Spodnja Slivnica</naziv><Geo_sirina>45.93454166</Geo_sirina><Geo_dolzina>14.65514444</Geo_dolzina></postaja><postaja><st>43652</st><naziv>Središče</naziv><Geo_sirina>46.38922777</Geo_sirina><Geo_dolzina>16.27715833</Geo_dolzina></postaja><postaja><st>42855</st><naziv>Stara Cerkev</naziv><Geo_sirina>45.66925277</Geo_sirina><Geo_dolzina>14.83800833</Geo_dolzina></postaja><postaja><st>44505</st><naziv>Steske</naziv><Geo_sirina>45.87610555</Geo_sirina><Geo_dolzina>13.75757500</Geo_dolzina></postaja><postaja><st>43800</st><naziv>Stranje</naziv><Geo_sirina>46.21725000</Geo_sirina><Geo_dolzina>15.55995277</Geo_dolzina></postaja><postaja><st>43352</st><naziv>Strnišče</naziv><Geo_sirina>46.40070000</Geo_sirina><Geo_dolzina>15.77048611</Geo_dolzina></postaja><postaja><st>43417</st><naziv>Sveti Danijel</naziv><Geo_sirina>46.60259166</Geo_sirina><Geo_dolzina>15.06366944</Geo_dolzina></postaja><postaja><st>43806</st><naziv>Sveti Rok ob Sotli</naziv><Geo_sirina>46.20893055</Geo_sirina><Geo_dolzina>15.76005555</Geo_dolzina></postaja><postaja><st>43418</st><naziv>Sveti Vid</naziv><Geo_sirina>46.61168611</Geo_sirina><Geo_dolzina>15.18827500</Geo_dolzina></postaja><postaja><st>43776</st><naziv>Šalovci</naziv><Geo_sirina>46.82114444</Geo_sirina><Geo_dolzina>16.28208888</Geo_dolzina></postaja><postaja><st>75605</st><naziv>Šapjane (HR)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>44603</st><naziv>Šempeter pri Gorici</naziv><Geo_sirina>45.92821944</Geo_sirina><Geo_dolzina>13.64681666</Geo_dolzina></postaja><postaja><st>43903</st><naziv>Šempeter v Savinjski dolini</naziv><Geo_sirina>46.26046388</Geo_sirina><Geo_dolzina>15.11215833</Geo_dolzina></postaja><postaja><st>43453</st><naziv>Šentilj</naziv><Geo_sirina>46.67415833</Geo_sirina><Geo_dolzina>15.65788333</Geo_dolzina></postaja><postaja><st>43102</st><naziv>Šentjur</naziv><Geo_sirina>46.21318055</Geo_sirina><Geo_dolzina>15.39624444</Geo_dolzina></postaja><postaja><st>42703</st><naziv>Šentlovrenc</naziv><Geo_sirina>45.93806944</Geo_sirina><Geo_dolzina>14.94092500</Geo_dolzina></postaja><postaja><st>42906</st><naziv>Šentrupert</naziv><Geo_sirina>45.95957222</Geo_sirina><Geo_dolzina>15.08767222</Geo_dolzina></postaja><postaja><st>43251</st><naziv>Šentvid pri Grobelnem</naziv><Geo_sirina>46.22745555</Geo_sirina><Geo_dolzina>15.47023888</Geo_dolzina></postaja><postaja><st>42706</st><naziv>Šentvid pri Stični</naziv><Geo_sirina>45.94083055</Geo_sirina><Geo_dolzina>14.84989166</Geo_dolzina></postaja><postaja><st>43360</st><naziv>Šikole</naziv><Geo_sirina>46.40092222</Geo_sirina><Geo_dolzina>15.69696388</Geo_dolzina></postaja><postaja><st>42306</st><naziv>Škofja Loka</naziv><Geo_sirina>46.17423888</Geo_sirina><Geo_dolzina>14.33554444</Geo_dolzina></postaja><postaja><st>42802</st><naziv>Škofljica</naziv><Geo_sirina>45.98448333</Geo_sirina><Geo_dolzina>14.57296111</Geo_dolzina></postaja><postaja><st>42362</st><naziv>Šmarca</naziv><Geo_sirina>46.19309722</Geo_sirina><Geo_dolzina>14.58860833</Geo_dolzina></postaja><postaja><st>43252</st><naziv>Šmarje pri Jelšah</naziv><Geo_sirina>46.23052500</Geo_sirina><Geo_dolzina>15.51690000</Geo_dolzina></postaja><postaja><st>42801</st><naziv>Šmarje-Sap</naziv><Geo_sirina>45.97497222</Geo_sirina><Geo_dolzina>14.61757222</Geo_dolzina></postaja><postaja><st>43905</st><naziv>Šmartno ob Paki</naziv><Geo_sirina>46.32798611</Geo_sirina><Geo_dolzina>15.03771388</Geo_dolzina></postaja><postaja><st>43907</st><naziv>Šoštanj</naziv><Geo_sirina>46.37669444</Geo_sirina><Geo_dolzina>15.04955833</Geo_dolzina></postaja><postaja><st>03185</st><naziv>Špilje/Spielfeld-Strass(A)</naziv><Geo_sirina xsi:nil=\"true\" /><Geo_dolzina xsi:nil=\"true\" /></postaja><postaja><st>44503</st><naziv>Štanjel</naziv><Geo_sirina>45.81785833</Geo_sirina><Geo_dolzina>13.84794722</Geo_dolzina></postaja><postaja><st>42701</st><naziv>Štefan</naziv><Geo_sirina>45.91270555</Geo_sirina><Geo_dolzina>14.98021388</Geo_dolzina></postaja><postaja><st>43101</st><naziv>Štore</naziv><Geo_sirina>46.22153888</Geo_sirina><Geo_dolzina>15.32192777</Geo_dolzina></postaja><postaja><st>43807</st><naziv>Tekačevo</naziv><Geo_sirina>46.24037777</Geo_sirina><Geo_dolzina>15.61839444</Geo_dolzina></postaja><postaja><st>43412</st><naziv>Trbonje</naziv><Geo_sirina>46.60527777</Geo_sirina><Geo_dolzina>15.11055555</Geo_dolzina></postaja><postaja><st>43416</st><naziv>Trbonjsko jezero</naziv><Geo_sirina>46.59388888</Geo_sirina><Geo_dolzina>15.12611111</Geo_dolzina></postaja><postaja><st>42203</st><naziv>Trbovlje</naziv><Geo_sirina>46.12641111</Geo_sirina><Geo_dolzina>15.03671388</Geo_dolzina></postaja><postaja><st>42700</st><naziv>Trebnje</naziv><Geo_sirina>45.90696666</Geo_sirina><Geo_dolzina>15.00857222</Geo_dolzina></postaja><postaja><st>42909</st><naziv>Trebnje Kamna Gora</naziv><Geo_sirina>45.90611944</Geo_sirina><Geo_dolzina>15.02447222</Geo_dolzina></postaja><postaja><st>42359</st><naziv>Trzin</naziv><Geo_sirina>46.13283611</Geo_sirina><Geo_dolzina>14.56758888</Geo_dolzina></postaja><postaja><st>42366</st><naziv>Trzin ind. cona</naziv><Geo_sirina>46.11890555</Geo_sirina><Geo_dolzina>14.55093055</Geo_dolzina></postaja><postaja><st>42358</st><naziv>Trzin Mlake</naziv><Geo_sirina>46.12860277</Geo_sirina><Geo_dolzina>14.55966944</Geo_dolzina></postaja><postaja><st>42903</st><naziv>Tržišče</naziv><Geo_sirina>45.96668055</Geo_sirina><Geo_dolzina>15.19080277</Geo_dolzina></postaja><postaja><st>42509</st><naziv>Uršna sela</naziv><Geo_sirina>45.71448055</Geo_sirina><Geo_dolzina>15.12766944</Geo_dolzina></postaja><postaja><st>43910</st><naziv>Velenje</naziv><Geo_sirina>46.36337222</Geo_sirina><Geo_dolzina>15.10413333</Geo_dolzina></postaja><postaja><st>43909</st><naziv>Velenje Pesje</naziv><Geo_sirina>46.36805277</Geo_sirina><Geo_dolzina>15.08127222</Geo_dolzina></postaja><postaja><st>42702</st><naziv>Velika Loka</naziv><Geo_sirina>45.93216944</Geo_sirina><Geo_dolzina>14.96951666</Geo_dolzina></postaja><postaja><st>43358</st><naziv>Velika Nedelja</naziv><Geo_sirina>46.41519722</Geo_sirina><Geo_dolzina>16.10500555</Geo_dolzina></postaja><postaja><st>42852</st><naziv>Velike Lašče</naziv><Geo_sirina>45.84168888</Geo_sirina><Geo_dolzina>14.64530555</Geo_dolzina></postaja><postaja><st>43701</st><naziv>Veržej</naziv><Geo_sirina>46.57425277</Geo_sirina><Geo_dolzina>16.18205277</Geo_dolzina></postaja><postaja><st>43809</st><naziv>Vidina</naziv><Geo_sirina>46.21675277</Geo_sirina><Geo_dolzina>15.72971666</Geo_dolzina></postaja><postaja><st>44718</st><naziv>Vintgar</naziv><Geo_sirina>46.41022777</Geo_sirina><Geo_dolzina>14.09871111</Geo_dolzina></postaja><postaja><st>42709</st><naziv>Višnja Gora</naziv><Geo_sirina>45.95797222</Geo_sirina><Geo_dolzina>14.74231666</Geo_dolzina></postaja><postaja><st>44602</st><naziv>Volčja Draga</naziv><Geo_sirina>45.90585555</Geo_sirina><Geo_dolzina>13.67576944</Geo_dolzina></postaja><postaja><st>43410</st><naziv>Vuhred</naziv><Geo_sirina>46.59639444</Geo_sirina><Geo_dolzina>15.23602777</Geo_dolzina></postaja><postaja><st>43409</st><naziv>Vuhred elektrarna</naziv><Geo_sirina>46.58647222</Geo_sirina><Geo_dolzina>15.27984444</Geo_dolzina></postaja><postaja><st>43411</st><naziv>Vuzenica</naziv><Geo_sirina>46.59377777</Geo_sirina><Geo_dolzina>15.15837777</Geo_dolzina></postaja><postaja><st>42204</st><naziv>Zagorje</naziv><Geo_sirina>46.12077500</Geo_sirina><Geo_dolzina>14.99102222</Geo_dolzina></postaja><postaja><st>43359</st><naziv>Zamušani</naziv><Geo_sirina>46.42138055</Geo_sirina><Geo_dolzina>16.01635833</Geo_dolzina></postaja><postaja><st>42200</st><naziv>Zidani Most</naziv><Geo_sirina>46.08546111</Geo_sirina><Geo_dolzina>15.17064444</Geo_dolzina></postaja><postaja><st>43902</st><naziv>Žalec</naziv><Geo_sirina>46.24969166</Geo_sirina><Geo_dolzina>15.16627222</Geo_dolzina></postaja><postaja><st>42710</st><naziv>Žalna</naziv><Geo_sirina>45.93973055</Geo_sirina><Geo_dolzina>14.70753611</Geo_dolzina></postaja><postaja><st>42314</st><naziv>Žirovnica</naziv><Geo_sirina>46.40188055</Geo_sirina><Geo_dolzina>14.13547500</Geo_dolzina></postaja><postaja><st>42860</st><naziv>Žlebič</naziv><Geo_sirina>45.76787500</Geo_sirina><Geo_dolzina>14.69253611</Geo_dolzina></postaja></postaje></PostajeResult></PostajeResponse></soap:Body></soap:Envelope>
"""
    
    var stationTracker: [Station] = .init()
    
    let parsedXML = try! XML.parse(rawResponse)
    
    for hit in parsedXML["soap:Envelope", "soap:Body", "PostajeResponse", "PostajeResult", "postaje", "postaja"]
    {
        
        if let latitude = hit["Geo_sirina"].double
        {
            if let longitude = hit["Geo_dolzina"].double
            {
                stationTracker.append(Station(id: hit["st"].int!, name: hit["naziv"].text!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
            }
        }
    }
    
    if case .failure(let error) = parsedXML["soap:Envelope", "soap:Body", "PostajeResponse", "PostajeResult", "postaje"] {
        print("Parsing Error: \(error)")
    }
    
    return stationTracker
}