/* eslint-disable no-trailing-spaces */
/* eslint-disable prettier/prettier */
/* eslint-disable react-native/no-inline-styles */

import React from 'react';
import {
  SafeAreaView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  Image,
  Pressable,
  TextInput
} from 'react-native';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <SafeAreaView style={{flex: 1}}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={'white'}
      />
      <View style={styles.container}>

        {/* HEADER */}
        <View style={styles.banner}>
          <Text style={styles.bannerText}>Example 1</Text>
        </View>

        {/* IMAGE */}
        <View
          style={{
            alignItems: 'center',
            justifyContent: 'center',
          }}>
          <Image
            source={require('./subjects_wheel.png')}
            style={{width: 100, height: 100}}
          />
        </View>

        {/* BUTTONS */}
        <View
          style={{
            display: 'flex',
            flexDirection: 'column',
            gap: 20,
          }}>
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'space-evenly',
            }}>
            <Pressable
              style={styles.button}>
              <Text>Button</Text>
            </Pressable>
            <Pressable
              style={styles.button}>
              <Text>Button</Text>
            </Pressable>
          </View>
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'space-evenly',
            }}>
            <Pressable
              style={styles.button}>
              <Text>Button</Text>
            </Pressable>
            <Pressable
              style={styles.button}>
              <Text>Button</Text>
            </Pressable>
          </View>
        </View>

        {/* EMAIL INPUT */}
        <View style={{display: 'flex', flexDirection: 'row', alignItems: 'center',justifyContent:'center', gap: 10, padding: 10}}>
          <Text style={{color: 'black'}}>Email</Text>
          <TextInput
          style={{width: 250, borderColor: 'red', borderBottomWidth: 1}}
      />
        </View>
        
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    display: 'flex',
    alignContent: 'center',
    flexDirection: 'column',
    gap: 20,
  },
  banner: {
    display: 'flex',
    padding: 10,
    height: 80,
    alignContent: 'center',
    justifyContent: 'center',
    backgroundColor: 'lightgreen',
  },
  bannerText: {
    fontWeight: 'bold',
    fontSize: 24,
    color: 'white',
  },
  buttons: {
    gap: 20,
    display: 'flex',
    flexDirection: 'column',
    backgroundColor: 'lightblue',
  },
  buttonRow: {
    display: 'flex',
    flexDirection: 'row',
    justifyContent: 'space-evenly',
  },
  button: {
    display: 'flex',
    height: 40,
    width: 80,
    backgroundColor: 'lightgray',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 5,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
