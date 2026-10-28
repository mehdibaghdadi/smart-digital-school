import React, { useState } from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { Zap, ShieldCheck, Clock, BookOpen, Users, MessageSquare, CheckCircle2 } from 'lucide-react';
import { Language, translations } from '../translations';

export const WhyUs = ({ lang }: { lang: Language }) => {
  const [activeTab, setActiveTab] = useState(0);
  const t = translations[lang].whyUs;
  
  const tabIcons = [<Zap size={20} />, <ShieldCheck size={20} />, <Clock size={20} />];
  const ecosystemIcons = [<BookOpen />, <Users />, <MessageSquare />];

  return (
    <section id="solution" className="py-16 bg-white dark:bg-dark-bg transition-colors">
      <motion.div 
        initial={{ opacity: 0, y: 50 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true }}
        transition={{ duration: 0.8, ease: "easeOut" }}
        className="max-w-7xl mx-auto px-6"
      >
        <div className="grid lg:grid-cols-2 gap-20 items-center">
          <div>
            <h2 className="text-4xl uppercase  font-extrabold text-slate-900 dark:text-white mb-8">
              {t.title.split('{span}')[0]}
              <span className="text-brand-600 dark:text-brand-500">{t.span}</span>
              {t.title.split('{span}')[1]}
            </h2>
            
            <div className="flex flex-wrap gap-4 mb-10">
              {t.tabs.map((tab, idx) => (
                <button
                  key={idx}
                  onClick={() => setActiveTab(idx)}
                  className={`flex items-center gap-2 px-6 py-3 rounded-full font-bold transition-all ${
                    activeTab === idx 
                      ? 'bg-brand-600 text-white shadow-lg shadow-brand-600/20' 
                      : 'bg-slate-50 dark:bg-dark-card text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-600'
                  }`}
                >
                  {tabIcons[idx]}
                  {tab.title}
                </button>
              ))}
            </div>

            <AnimatePresence mode="wait">
              <motion.div
                key={activeTab}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -20 }}
                transition={{ duration: 0.3 }}
              >
                <p className="text-xl text-slate-600 dark:text-slate-300 mb-8 leading-relaxed">
                  {t.tabs[activeTab].content}
                </p>
                <ul className="space-y-4">
                  {t.tabs[activeTab].features.map((f, i) => (
                    <li key={i} className="flex items-center gap-3 text-slate-900 dark:text-white font-semibold">
                      <CheckCircle2 size={20} className="text-brand-600 dark:text-brand-500" />
                      {f}
                    </li>
                  ))}
                </ul>
              </motion.div>
            </AnimatePresence>
          </div>

          <div className="relative">
            <div className="bg-slate-900 dark:bg-dark-card rounded-[40px] p-8 lg:p-12 text-white overflow-hidden relative border border-white/5">
              <div className="absolute top-0 right-0 w-64 h-64 bg-brand-500/20 rounded-full blur-3xl" />
              <h3 className="text-2xl font-bold mb-8 relative z-10">{t.ecosystemTitle}</h3>
              
              <div className="space-y-8 relative z-10">
                {t.ecosystemItems.map((item, idx) => (
                  <div key={idx} className="flex gap-6">
                    <div className="w-12 h-12 bg-white/10 rounded-xl flex items-center justify-center shrink-0">
                      {ecosystemIcons[idx]}
                    </div>
                    <div>
                      <h4 className="text-xl font-bold mb-2">{item.title}</h4>
                      <p className="text-slate-300 dark:text-slate-400 leading-relaxed">{item.desc}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </motion.div>
    </section>
  );
};
